## Plan

### Task A

- LIkely going to use Open5GS; made in C so its performant, and its Kubernetes native

https://medium.com/@linuxcares/aws-open5gs-kubernetes-setup-with-load-testing-8cf2fb4c7a83

### Task B

Going to use full K8s on a fully fledged VM with decent resourcing, and mini k8s on a slimmer VM to represent the edge computing.

### Task C

Use iperf3 for throughput and latency; ping for establishing base connection.

UERANSIM or gNBsim can be used for simulating real5g radio access.

Establish an idle baseline, stress test using ramped up traffic and high intensity downloads; test scalability/elasticity? Run multiple times.

### Task D

Collect CPU/memory, collect network throughput
