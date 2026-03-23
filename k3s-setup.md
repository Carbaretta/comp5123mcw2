# Fixing SSH key

chmod 600 k3s-edge-2_key.pem

# systemd-resolved

## Stop and disable the service

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

## Remove the symbolic link to resolv.conf

sudo rm /etc/resolv.conf

## Establish self reference

echo "127.0.0.1 k3s-edge-2" | sudo tee -a /etc/hosts

## Create a fresh resolv.conf pointing to a public DNS (so the VM can still reach the internet)

echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf

# k3s install

curl -sfL https://get.k3s.io | sh -s - --disable traefik

## Allow user to use kubectl without sudo

mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# install adguard

mkdir coursework/scripts

nano safety-vnf.yaml
// Paste deployment content here, then Ctrl+O, Enter, Ctrl+X

nano safety-service.yaml
// Paste service content here, then Ctrl+O, Enter, Ctrl+X

sudo kubectl apply -f coursework/scripts/

// veryify deployment is working:
sudo kubectl get pods -o wide

then go to ip:3000 and setup wizard.
