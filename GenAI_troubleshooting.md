## Troubleshooting

### .pem key permissions

I'm receiving the below error message when attempting to SSH into the Azure VM; give me the chmd command to set the right permissions.

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ WARNING: UNPROTECTED PRIVATE KEY FILE! @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0664 for 'minkube-lab.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "minkube-lab.pem": bad permissions
azureuser@20.68.162.215: Permission denied (publickey).

The GenAI suggested running chmod 400 for the given file. This worked.

### ENvironment variable access controls

The command kubectl get nodes is giving the error:

WARN[0000] Unable to read /etc/rancher/k3s/k3s.yaml, please start server with --write-kubeconfig-mode or --write-kubeconfig-group to modify kube config permissions 
error: error loading config file "/etc/rancher/k3s/k3s.yaml": open /etc/rancher/k3s/k3s.yaml: permission denied

The Gen AI once again suggested a change of permissions, chmod 644 this type on the target file. This worked.

# GenAI Troubleshooting Log

This document records the troubleshooting steps taken during the deployment and configuration of the Kubernetes-based Safety VNF (AdGuard Home) in both cloud and edge environments.

| Problem                                                                                                 | Proposed Solution                                                                                                                                 | Result                                                                    |
| :------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------ |
| SSH connection rejected with "Permissions 0664 are too open" for the `.pem` key file.                   | Restricted file permissions using `chmod 400` so only the owner can read the key.                                                                 | **Worked.** SSH now accepts the key for authentication.                   |
| `Permission denied (publickey)` error even after fixing file permissions.                               | Verified the correct identity file was being used with the `-i` flag and confirmed the Azure username.                                            | **Worked.** Successfully logged into the Azure VM.                        |
| [cite_start]`kubectl` command failed on Edge VM (K3s) with permission denied for `k3s.yaml`. [cite: 32] | [cite_start]Copied the K3s config to the user's home directory (`~/.kube/config`) and updated ownership/permissions. [cite: 32]                   | **Worked.** User can now run Kubernetes commands without root privileges. |
| [cite_start]AdGuard setup wizard reported "Port 53 is already in use" on the Edge VM. [cite: 32]        | [cite_start]Disabled the host's `systemd-resolved` service to free up the standard DNS port. [cite: 32]                                           | **Worked.** The VNF was able to bind to Port 53 for DNS filtering.        |
| [cite_start]`kubectl` command not found on Cloud VM after starting Minikube. [cite: 32]                 | [cite_start]Manually downloaded the `kubectl` binary using `curl` and installed it to `/usr/local/bin/`. [cite: 32]                               | **Worked.** The system can now interact with the Minikube cluster.        |
| [cite_start]AdGuard dashboard inaccessible via Public IP on the Cloud VM (Minikube). [cite: 32]         | [cite_start]Used `kubectl port-forward` with the `--address 0.0.0.0` flag to tunnel traffic from the VM's public interface to the pod. [cite: 32] | **Worked.** Dashboard is now reachable through the laptop's browser.      |

## Technical Opinion on GenAI Effectiveness

[cite_start]As part of the deliverable requirements[cite: 83], my technical opinion on the use of GenAI for this project is as follows:

[cite_start]The use of GenAI was highly effective for troubleshooting environment-specific configuration hurdles, particularly regarding Linux permission conflicts and Kubernetes networking nuances[cite: 19, 83]. [cite_start]It provided rapid diagnostic steps for standard error messages (like SSH permission issues or Port 53 conflicts) that typically require extensive manual searching through technical documentation[cite: 18, 19]. [cite_start]While the AI was not used to generate the core coursework solutions [cite: 20][cite_start], it served as a robust assistive tool for resolving deployment complexities between the cloud and edge environments[cite: 17, 36].
