#!/bin/bash
clear
echo -e "==============================="
echo -e "      CHANGE YOUR DOMAIN"
echo -e "==============================="

CURRENT_DOMAIN=$(cat /etc/xray/domain 2>/dev/null)
IP=$(curl -s ipv4.icanhazip.com)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-)

echo -e "Your Current Domain : $CURRENT_DOMAIN"
echo -e "IP                  : $IP"
echo -e "ISP                 : $ISP"
echo -ne "\nNew Domain: "; read NEW_DOMAIN

if [[ -n "$NEW_DOMAIN" ]]; then
    echo "$NEW_DOMAIN" > /etc/xray/domain
    echo "✅ Domain updated to: $NEW_DOMAIN"
else
    echo "❌ Domain not changed."
fi

read -n 1 -s -r -p "Tekan tombol apapun untuk kembali..."
