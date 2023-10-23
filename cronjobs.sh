#
cron_jobs(){
myRANDOM_HOUR=$(shuf -i 2-22 -n 1)
myRANDOM_MINUTE=$(shuf -i 0-59 -n 1)
myDEL_HOUR=$(($myRANDOM_HOUR+1))
mySTOP_HOUR=$(($myRANDOM_HOUR-1))
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

# Daily stop tcpdump & copy pcap to server 
$myRANDOM_MINUTE $mySTOP_HOUR * * 1-6     root    systemctl stop tcpdump.service && systemctl stop tcpdump.timer && sleep 10 &&  /home/tsec/SENSOR/compressor.sh"

echo "$myCRONJOBS" | tee -a /etc/crontab

}
