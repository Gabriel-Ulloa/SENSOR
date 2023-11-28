#!/bin/bash
#
myWHOAMI=$(whoami)
if [ "$myWHOAMI" != "root" ]
  then
    toilet -f future 'Password'
    sudo ./$0
    exit
fi
#
#Platform check
if [ -f "/etc/systemd/system/tpot.service" ]; then
    toilet -f pagga 'T-Pot'
    if [ -f "/etc/systemd/system/tcpdump.service" ]; then
        echo "This script is only executed once after installation"; sleep 3; exit 1
    else
        toilet -f pagga "OK"
    fi
else
    echo "This script only works on the T-Pot platform."; cd ..; rm -r SENSOR/; echo "exiting script..."; sleep 3
    exit 1
fi
# Verify if the containers are in execution
if [[ $(docker ps -q -f name=dionaea) && $(docker ps -q -f name=cowrie) && $(docker ps -q -f name=adbhoney) ]]; then
  echo "Containers are running"
else
  echo "Some of the containers are not running!"
  echo "exiting script...."
  sleep 3
  exit 1
fi
#
. ./ssh-key_generator.sh
. ./cronjobs.sh
. ./services.sh
. ./deploy.sh
. ./crontab.sh

main() {
    mkdir /home/tsec/PCAP
    mkdir /home/tsec/CATCHES
    mv "compressor.sh" "stopper.sh" /usr/local/bin/
    crontab
    cron_jobs
    set_services
    generate_ssh_key
    deploy_hive
    apt update && apt install -y --allow-change-held-packages pcp tcpdump cockpit-pcp
    toilet -f ivrit '...Installed'
    sleep 3
    dialog --keep-window --no-ok --no-cancel --backtitle "INSTALLED" --title "[ Restarting system... ]" --pause "" 7 80 5
    rm -r /home/tsec/SENSOR
    clear 
    reboot 
}

main

