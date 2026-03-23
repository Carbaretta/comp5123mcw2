## This breakdown provides a chronological narrative of the **Edge VM (K3s)** deployment.

### Phase 1: K3s Installation and Environment Setup

The goal was to establish a lightweight Kubernetes environment suitable for an Edge node.

1. **K3s Installation:** Executed the K3s install script to deploy a lightweight control plane.

2. **Permission Resolution:** Fixed the standard `kubectl` permission error where the non-root user can't access the cluster config.

3. **Directory Structure:** Established a standardized project folder to hold deployment manifests for the "Material" deliverable.

---

### Phase 2: Initial VNF Deployment

Deployed the AdGuard Home VNF using standard Kubernetes "Cluster Networking."

1. **Manifest Creation:** Created `safety-vnf.yaml` (Deployment) and `safety-service.yaml` (Service).
2. **Initial Access:** Successfully accessed the AdGuard dashboard on the **NodePort 32000**.
3. **The "Port 53" Conflict:** Discovered that the VNF couldn't start its DNS filtering because Ubuntu’s `systemd-resolved` was already using Port 53.

- **Debugging:** Used `netstat` and `lsof` to identify the conflict.
- **Fix:** Disabled the host DNS stub.
- **Command:** `sudo systemctl stop systemd-resolved && sudo systemctl disable systemd-resolved`

---

### Phase 3: Transition to "Edge-Optimized" Networking

Had to move from internal Kubernetes networking to **Host Networking** for both efficiency and a lot of issues with port forwarding.

1. **The "Bootstrap" Failure:** After disabling `systemd-resolved`, the VM lost its ability to resolve Docker Hub, leading to an `ImagePullBackOff` error.

- **Debugging:** Identified the Circular Dependency where the VM needed the VNF for DNS, but needed DNS to download the VNF.
- **Fix:** Manually injected a temporary nameserver into the OS.
- **Command:** `echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf`

2. **HostNetwork Migration:** Updated the YAML manifest to `hostNetwork: true`. This bypassed the Kube-Proxy and mapped the VNF directly to the VM's network interface to achieve the Ultra-Low Latency required for Edge functions.
3. **Privilege Escalation:** Discovered that even with host networking, the pod couldn't "grab" Port 53 from the OS without higher permissions.

- **Fix:** Added `privileged: true` and `dnsPolicy: ClusterFirstWithHostNet` to the manifest.

---

### Phase 4: Final Validation and Testing

The final stage involved ensuring the "Safety Product" was actually filtering traffic as per Task (c).

1. **Ghost Process Cleanup:** Ran a "Hard Reset" to kill lingering processes and stale pods that were causing Port 53 binding failures.

2. **Verification of Listener:** Confirmed that AdGuard was successfully "holding" the VM's port.

- **Command:** `sudo lsof -iUDP:53 -nP`

3. **"Hello World" Test:** Verified from laptop that the Edge VM was resolving queries and blocking spam domains (e.g., `doubleclick.net`).
