#!/bin/bash

packer(){

honeys=("/data/adbhoney" "/data/cowrie" "/data/dionaea")
catches="/home/tsec/catches"
temp="/home/tsec"

for subdirs in "${honeys[@]}"; do
    cp -r "$subdirs" "$catches"
done

tar -cvf $temp/catches.tar $catches
tar -czvf $temp/$(date +%A)_catches.tar.gz $temp/catches.tar && rm $temp/catches.tar
sleep 2                

scp $temp/$(date +%A)_catches.tar.gz root@192.17.200.101:/home/captures
sleep 3
rm $temp/$(date +%A)_catches.tar.gz && rm -r $catches/*

}
