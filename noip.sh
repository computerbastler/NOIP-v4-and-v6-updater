#!/bin/bash
USERNAME="Benutzer"
PASSWORD="Password"
HOST="Name.ddns.net"
USERAGENT="Datenreise NOIP Updater/0.4"
INTERFACE="enp1s0"
IP4=$(curl -s https://api.ipify.org)
IP6=$(ip -6 addr show dev $INTERFACE | awk '/inet6/ {print $2}' | cut -d/ -f1 | head -n 1)
curl -s -k -u $USERNAME:$PASSWORD --user-agent "$USERAGENT" "https://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP4"
curl -s -k -u $USERNAME:$PASSWORD --user-agent "$USERAGENT" "https://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP6"
