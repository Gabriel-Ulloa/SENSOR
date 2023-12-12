# SENSOR

## Overview

SENSOR is a robust cyber-security framework designed to proactively engage with external threats through a collection of specialized honeypots. It simulates vulnerabilities to bait and capture malicious activities, providing an intricate layer of security for network systems.

## Features

### Honeypots Integration
Incorporates three dynamic honeypots - Dionaea, Cowrie, and ADBhoney - each offering unique services to entice potential attackers.
### Traffic Capture 
Utilizes tcpdump to monitor all incoming traffic, meticulously logging interactions for analysis.
### Automated Maintenance
Automated daily reboots from Monday to Saturday, with comprehensive maintenance and updates every Sunday.
### Capture and Storage
Prior to daily reboots, a tailored script transfers and compresses relevant captured data, including pcap files and intercepted binaries, to a secure storage location.

## Installation

1. Copy the command located in command.txt
2. Paste the command into the terminal of your T-Pot Hive-Sensor deployment
3. Follow the instructions

## Usage

The platform is scheduled for automatic interaction with potential threats. For manual control and further customization, refer to cronjobs.sh and services.sh.

## Contribution

Contributions to SENSOR are welcome. Please submit pull requests for any enhancements or fixes.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Acknowledgments

SENSOR is part of a larger initiative to enhance network security. We extend our gratitude to all contributors and the open-source community for their ongoing support.
