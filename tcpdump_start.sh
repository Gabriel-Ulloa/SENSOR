#!/bin/bash
#
tcpdump -i eth0 -w /home/tsec/PCAP/$(date +%A).pcap