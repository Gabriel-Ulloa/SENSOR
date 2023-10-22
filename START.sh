#!/bin/bash
source ./ssh-key_generator.sh
source ./crons.sh
source ./services.sh
#Ejecutar en root
# Got root?
myWHOAMI=$(whoami)
if [ "$myWHOAMI" != "root" ]
  then
    toilet -f future 'Password'
    sudo ./$0
    exit
fi
#
#CHECHEO DE PLATAFORMA
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
# Verificar si los contenedores están en ejecución
if [[ $(docker ps -q -f name=dionaea) && $(docker ps -q -f name=cowrie) && $(docker ps -q -f name=adbhoney) ]]; then
  echo "Containers are running"
else
  echo "Some of the containers are not running!"
  echo "exiting script...."
  sleep 3
  exit 1
fi
#
main() {
    mkdir /home/tsec/PCAP
    generate_ssh_key
    cp crontab /etc/
    cron_jobs
    set_services
    apt install tcpdump pcp cockpit-pcp
    toilet -f ivrit '...Instalado'
    sleep 3
    dialog --keep-window --no-ok --no-cancel --backtitle "$myBACKTITLE" --title "[ Reiniciando el sistema... ]" --pause "" 7 80 5
    clear 
    reboot 
}

main

