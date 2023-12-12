# SENSOR Repository

Welcome to the SENSOR repository, part of our integrated network security and forensic analysis solution, deployed on a T-Pot platform with the HIVE-SENSOR installation.

## Overview

This repository is the first step in our security workflow, where various honeypots like Dionaea, Cowrie, and ADBHoney are deployed to simulate vulnerabilities and capture malicious traffic.

## Operation

The SENSOR platform is exposed to the internet via a public IP address to capture attacks. It incorporates:
- **Active Honeypots**: Dionaea, Cowrie, and ADBHoney to simulate vulnerabilities.
- **Traffic Capture**: Utilizing `tcpdump` to capture all incoming traffic.
- **Maintenance Schedule**: Automated reboots and maintenance, including updates and directory cleanup.
- **Data Transfer**: Before daily reboots, a script transfers pcap files and logs to the `CATCHES` folder for compression and SCP transfer to the `sensor_catches` directory.

## Installation

1. Copy the command located in command.txt
2. Paste the command into the terminal of your T-Pot Hive-Sensor deployment
3. Follow the instructions

## Next Steps

Post-capture, the data processed by SENSOR is handed over to the IMPORT repository for further refinement and analysis, operated on a Security Onion setup with the import PCAP installation.

## Contribution

For guidelines on how to contribute to the SENSOR repository, please refer to our contributing guidelines document.

Thank you for contributing to the SENSOR repository, helping us create a safer digital environment.

