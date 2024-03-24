#!/bin/bash

ram_status=$(free -m | awk 'NR==2{OFS=",";print $2,$3,$4,$5,$6,$7}')
swap_status=$(free -m | awk 'NR==3{OFS=",";print $2,$3,$4}')
disk_status=$(du -sh "/home/rafaelega24" | awk '{print $1}')

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff_cache,mem_available,swap_total,swap_used,swap_free,path,path_size" > "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"
echo "$ram_status,$swap_status,/home/rafaelega24,$disk_status" >> "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"
chmod 400 "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"

#konfigurasi crontab
#* * * * * /home/rafaelega24/SISOP/modul1/4/minute_log.sh
