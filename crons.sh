#!/bin/bash
##
cron_jobs(){
myRANDOM_HOUR=$(shuf -i 2-22 -n 1)
myRANDOM_MINUTE=$(shuf -i 0-59 -n 1)
myDEL_HOUR=$(($myRANDOM_HOUR+1))
myPULL_HOUR=$(($myRANDOM_HOUR-2))

myCRONJOBS="
# Check if updated images are available and download them every sunday
$myRANDOM_MINUTE $myPULL_HOUR * * 0      root    docker-compose -f /opt/tpot/etc/tpot.yml pull

# Uploaded binaries are not supposed to be downloaded
*/1 * * * *     root    mv --backup=numbered /data/dionaea/roots/ftp/* /data/dionaea/binaries/

# Daily reboot
$myRANDOM_MINUTE $myRANDOM_HOUR * * 1-6      root    systemctl stop tpot && docker stop \$(docker ps -aq) && docker rm \$(docker ps -aq); reboot

# Check for updated packages every sunday, upgrade and reboot
$myRANDOM_MINUTE $myRANDOM_HOUR * * 0     root    apt-fast autoclean -y && apt-fast autoremove -y && apt-fast update -y && apt-fast upgrade -y && sleep 10 && reboot
"

fuBANNER "Add cronjobs"
echo "$myCRONJOBS" | tee -a /etc/crontab

set_crons

}

set_crons(){
    local ip="$server_ip"
    CRON_DIR="/etc/crontab"
  
    function CMIN(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 | cut -c 1-2 
    }

    function CHOUR(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 |cut -c 3-5
    }
    #Stop TCPDump and compress catches
    echo "#Stop tcpdump & copy pcap to server" >> $CRON_DIR
    echo $(CMIN)  $(expr $(CHOUR) - 1) "* * 1-6     root    systemctl stop tcpdump.service && systemctl stop tcpdump.timer && sleep 10 &&  /home/tsec/SENSOR/compressor.sh" >> $CRON_DIR
    echo ""
    #
}
