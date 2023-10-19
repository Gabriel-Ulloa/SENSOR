#!/bin/bash

copy_honeys(){

subdirectorios=("/data/adbhoney" "/data/cowrie" "/data/dionaea")
directorio_destino="/home/tsec/pruebas"

for subdir in "${subdirectorios[@]}"; do
    cp -r "$subdir" "$directorio_destino"
done

}


tar -cvf 
tar -czvf                       #agregar gz

scp /home/tsec/PCAP/tcpdump.pcap root@192.17.200.101:/home/