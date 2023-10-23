#!/bin/bash
#
packer(){

honeys=("/data/adbhoney" "/data/cowrie" "/data/dionaea")
pcap="/home/tsec/PCAP/capture.pcap"
catches="/home/tsec/CATCHES"
temp="/home/tsec"

for subdirs in "${honeys[@]}"; do
    cp -r "$subdirs" "$catches"
done

cp $pcap $catches/$(date +%A).pcap
tar -cvf $temp/catches.tar $catches
tar -czvf $temp/$(date +%A)_catches.tar.gz $temp/catches.tar && rm $temp/catches.tar
sleep 2                

scp $temp/$(date +%A)_catches.tar.gz root@$(cat server.txt):/home/captures/
sleep 3
rm $temp/$(date +%A)_catches.tar.gz && rm -r $catches/*

}

packer