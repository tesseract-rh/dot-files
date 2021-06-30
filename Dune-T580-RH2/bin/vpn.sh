#!/bin/bash
#
# Use nmcli to display the VPN status
#
if nmcli -t -f name,type con show --active | grep -q vpn; then
  echo "up"
else
  echo "down"
fi
