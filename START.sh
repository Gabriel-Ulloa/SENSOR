#!/bin/bash
source ./ssh-key_generator.sh
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
#Estableciendo zona horaria..."
timedatectl set-timezone UTC
timedatectl set-ntp true

mkdir /home/tsec/PCAP

main() {
    generate_ssh_key
    cron_jobs
    
    exit
}

main

cp tcpdump.service /etc/systemd/system/
cp tcpdump.timer /etc/systemd/system/
systemctl daemon-reload
systemctl enable tcpdump.timer

apt install tcpdump pcp cockpit-pcp 

#PROTECTION
#chattr +i *
#chmod 600 /home/tsec/CHECKS /home/tsec/PCAP /home/tsec/SCRIPT
#Finished
toilet -f ivrit '...Instalado'
sleep 3
dialog --keep-window --no-ok --no-cancel --backtitle "$myBACKTITLE" --title "[ Reiniciando el sistema... ]" --pause "" 7 80 5
clear 
reboot