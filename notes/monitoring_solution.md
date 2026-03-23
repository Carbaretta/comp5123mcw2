# Commands for setting up system monitoring

wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz

sudo tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz

sudo nohup ./node_exporter > node_exporter.log 2>&1 &

## Verify working:

pgrep -a node_exporter
ss -tulpn | grep :9100
tail -f node_exporter.log
