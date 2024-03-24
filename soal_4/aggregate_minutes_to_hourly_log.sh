#!/bin/bash

for file in /home/rafaelega24/log/*.log; do
    head -n 2 "$file" | tail -n 1 >> "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log"
done

min_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk -F, '{for(i=1;i<=NF;i++) sum[i]+=$i} END {for(i=1;i<=NF;i++) printf sum[i]/NR ","}' | sed 's/,$//')
min_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk -F, '{for(i=1;i<=NF;i++) sum[i]+=$i} END {for(i=1;i<=NF;i++) printf sum[i]/NR ","}' | sed 's/,$//')
min_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk '{sum+=$1} END {print sum/NR}')

echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
maximum,$max_ram_status,$max_swap_status,/home/rafaelega24,$max_disk_status
minimum,$min_ram_status,$min_swap_status,/home/rafaelega24,$min_disk_status 
avgerage,$avg_ram_status,$avg_swap_status,/home/rafaelega24,$avg_disk_status" | sudo tee "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log"

#konfigurasi crontab
#0 * * * * /home/rafaelega24/SISOP/modul1/4/aggregate_minutes_to_hourly_log.sh
