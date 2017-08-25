#!/bin/bash
#Filename: uptime.sh
#Description: Uptime monitor

IP_LIST="192.168.0.1 192.168.0.5 192.168.0.9"
USER="test"

for IP in $IP_LIST;
do
  utime=$(ssh ${USER}@${IP} uptime  | awk '{ print $3 }' )
  echo $IP uptime:  $utime
done