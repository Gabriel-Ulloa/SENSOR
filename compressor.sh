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

mv $pcap $catches/$(date +%A).pcap
cd $temp && tar -cv CATCHES/ | gzip > $(date +%A)_catches.tar.gz
sleep 2                
scp $temp/$(date +%A)_catches.tar.gz $(cat /usr/local/bin/server):/home/import/Deployment/sensor_catches
sleep 3
rm $temp/$(date +%A)_catches.tar.gz && rm -r $catches/*

}

packer