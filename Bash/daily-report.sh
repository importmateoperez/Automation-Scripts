#!/bin/bash

#Get Hostname
HOSTNAME=$(hostname)

#Info Collection
UPTIME=$(uptime -p)
DISK=$(df -h / | tail -1)
MEMORY$(free -h | awk '/Mem:/ {print $3 " used of " $2}')
CPU=$(top -bn1 | grep "Cpu" | awk '{print 100 - $8"% idle"}')

#Apache Status
APACHE_STATUS=$(systemctl is-active apache2)

#Updates Available
UPDATES=$(apt list --upgradeable 2>/dev/null | grep -c upgradeable)

#Apply Security Updates
AUTO_UPDATES=$(grep -i "Unattended-Upgrade::Automatic Reboot" /etc/apt/apt.conf.d/* 2>/dev/null | wc -l)

#Build Report

REPORT="
Server: $HOSTNAME
Date: $(date)

Uptime: $UPTIME

CPU Load: $CPU

Disk Usage: $DISK

Memory Usage: $MEMORY

Apache Status: $APACHE_STATUS

Pending Updates: $UPDATES

Automatic Updates Enabled: $AUTO_UPDATES
"

#Send Email
echo "$REPORT" | mail -s "Daily Report - $HOSTNAME" example@gmail.com