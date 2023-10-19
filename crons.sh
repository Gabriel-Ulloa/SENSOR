#!/bin/bash
#
set_crons(){
    local ip="$server_ip"
    CRON_DIR="/etc/crontab"
    #Preparando Captura y Tiempos
    mkdir /home/tsec/PCAP
    #Configurando arranque TCPDUMP"
    sed -i -e '$i\/home/tsec/SENSOR/tcpdump_start.sh &' /etc/rc.local
    #
    function CMIN(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 | cut -c 1-2 
    }
    #
    function CHOUR(){
    grep -A 1 Daily $CRON_DIR |head -n 2 | tail -n 1 |cut -c 3-5
    }
    #COmprimir Honeypots
    echo "#">> $CRON_DIR
    echo "#Stop tcpdump everyday" >> $CRON_DIR
    echo $(CMIN)  $(expr $(CHOUR) - 1) "* * 1-6     root    killall tcpdump && sleep 30 && scp /home/tsec/PCAP/tcpdump.pcap root@$ip:/home/" >> $CRON_DIR
    echo ""
    #
}


#grep -A 1 "images are available" crontab | awk NR==2 | sed -i 's/\(* *\*\) \*/\1 1-6/' crontab

#grep -A 1 "Check if" crontab | awk NR==2 

#sed -i 's/*\* \*/* * 1-6/' crontab

#sed -i 's/26 12 \* \*/26 12 1-6 */' /ruta/del/archivo

#sed -i 's/\(* *\*\) \*/\1 1-6/' /ruta/del/archivo

#scp /etc/grc.conf 192.17.200.101:/home/

grep -A 2 "images are available" crontab 