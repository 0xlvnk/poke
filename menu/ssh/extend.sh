#!/bin/bash
read -rp "Username yang ingin diperpanjang: " user
if id "$user" &>/dev/null; then
    read -rp "Tambahkan berapa hari?: " days
    chage -E $(date -d "+$days days" +%Y-%m-%d) "$user"
    echo "✅ Masa aktif user '$user' telah diperpanjang $days hari."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
