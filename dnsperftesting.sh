VM_IP="172.187.176.156"
QUERY_FILE="dns_list.txt"

for level in 1 2 3 4 5; do
    CLIENTS=$((level * 40))
    QPS=$((level * 600))
    
    echo "--------------------------------------------------"
    echo "STAGE $level: Clients=$CLIENTS | Max QPS=$QPS"
    echo "--------------------------------------------------"
    
    # Run dnsperf and append to a master results file
    dnsperf -s $VM_IP -d $QUERY_FILE -l 60 -c $CLIENTS -Q $QPS >> full_benchmark_results.txt
    
    echo "Stage $level complete. Cooling down for 10s"
    sleep 10
done
