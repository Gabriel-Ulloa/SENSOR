#!/bin/bash
#
/bin/systemctl stop tcpdump.service
sleep 5
bash /usr/local/bin/compressor.sh
sleep 60
reboot