#!/bin/bash
read -rp "Username yang ingin diganti passwordnya: " user
if id "$user" &>/dev/null; then
    passwd "$user"
else
    echo "❌ User '$user' tidak ditemukan!"
fi
read -n 1 -s -r -p "Tekan tombol apapun untuk kembali..."
