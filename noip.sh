#!/bin/bash
USERNAME="input username"
PASSWORD="input password"
HOST="input host adress name"
USERAGENT="Datenreise NOIP Updater/0.4"
INTERFACE="input Networkinterface"

# Get initial IP address
IP4=$(curl -s http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
IP6=$(ip -6 addr show dev $INTERFACE | awk '/inet6/ {print $2}' | cut -d/ -f1 | head -n 1)

while true; do
  # Get current IP address
  CURRENT_IP4=$(curl -s http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
  CURRENT_IP6=$(ip -6 addr show dev enp2s0 | awk '/inet6/ {print $2}' | cut -d/ -f1 | head -n 1)

  # Compare current IP to previous IP
  if [ "$CURRENT_IP4" != "$IP4" ]; then
    # Update IP address
    IP4=$CURRENT_IP4
    curl -s -k -u $USERNAME:$PASSWORD --user-agent "$USERAGENT" "https://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP4"
  fi
  if [ "$CURRENT_IP6" != "$IP6" ]; then
    # Update IP address
    IP6=$CURRENT_IP6
    curl -s -k -u $USERNAME:$PASSWORD --user-agent "$USERAGENT" "https://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP6"
  fi

  # Sleep for 30 seconds before next IP check
  sleep 30
done
