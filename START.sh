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

main() {
    generate_ssh_key
    set_crons
    
    exit
}

main

apt update && apt install -y tcpdump

#PROTECTION
#chattr +i *
#chmod 600 /home/tsec/CHECKS /home/tsec/PCAP /home/tsec/SCRIPT
#Finished
toilet -f ivrit '...Instalado'
sleep 3
dialog --keep-window --no-ok --no-cancel --backtitle "$myBACKTITLE" --title "[ Reiniciando el sistema... ]" --pause "" 7 80 5
clear 
reboot