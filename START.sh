#!/bin/bash
#
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
    toilet -f pagga 'Plataforma T-POT'
    if [ -f "/home/tsec/PCAP/tcpdump.pcap" ]; then
        echo "Este script solo se ejectuta una vez despues de la instalacion"; sleep 3; exit 1
    else
        echo "Plataforma T-Pot: OK"
    fi
else
    echo "Este script solo funciona en la plataforma T-Pot."; cd ..; rm -r SCRIPT/; echo "Saliendo..."; sleep 3
    exit 1
fi
# Verificar si los contenedores están en ejecución
if [[ $(docker ps -q -f name=dionaea) && $(docker ps -q -f name=cowrie) && $(docker ps -q -f name=adbhoney) ]]; then
  echo "Los contenedores están en ejecución."
else
  echo "Alguno de los contenedores no está en ejecución. Saliendo del script."
  sleep 3
  exit 1
fi
#
#Estableciendo zona horaria..."
timedatectl set-timezone UTC
timedatectl set-ntp true

CRON_DIR="/etc/crontab"

apt update && apt install -y tcpdump
echo "Directorios y scripts"
mkdir /home/tsec/PCAP
#
echo "Configurando Demonios..."
sed -i -e '$i\/home/tsec/SENSOR/tcpdump_start.sh &' /etc/rc.local
#
function CMIN(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 | cut -c 1-2 
}
#
function CHOUR(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 |cut -c 3-5
}
#
echo "#">> $CRON_DIR
echo "#Stop tcpdump & check captures everyday" >> $CRON_DIR
echo $(CMIN)  $(expr $(CHOUR) - 1) "* * *      root    killall tcpdump && sleep 30 && scp /home/tsec/PCAP/tcpdump.pcap root@192.17.200.101:/home/" >> $CRON_DIR
echo ""
#
#PROTECTION
#chattr +i *
#chmod 600 /home/tsec/CHECKS /home/tsec/PCAP /home/tsec/SCRIPT
#Finished
toilet -f ivrit '...Instalado'
sleep 3
dialog --keep-window --no-ok --no-cancel --backtitle "$myBACKTITLE" --title "[ Reiniciando el sistema... ]" --pause "" 7 80 5
clear 
reboot