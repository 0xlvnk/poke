#!/bin/bash
read -rp "Username yang ingin diperpanjang: " user
if id "$user" &>/dev/null; then
    read -rp "Tambah hari berapa: " days
    chage -E $(date -d "+$days days" +%Y-%m-%d) "$user"
    echo "✅ Masa aktif user '$user' diperpanjang $days hari."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
read -n 1 -s -r -p "Tekan tombol apapun untuk kembali..."
