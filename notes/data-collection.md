# Create anda pply node-exporter.yaml in both VMs

kubectl apply -f coursework/scripts/node-exporter.yaml

## Create ssh tunnel to get data from node-exporter to local machine

ssh -i k3s-edge-2_key.pem -L 9101:localhost:9110 azureuser@172.187.176.156

## Then setup prometheus on local machine`

`prometheus.yml`:
global:
scrape_interval: 5s
scrape_configs:

- job_name: 'azure-edge'
  static_configs:
  - targets: ['localhost:9101']

### Run that yaml on local:

docker run -d \
 --name prometheus \
 --network host \
 -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml \
 prom/prometheus
