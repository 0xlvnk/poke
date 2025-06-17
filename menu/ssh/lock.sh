#!/bin/bash
read -rp "Username yang ingin dikunci: " user
if id "$user" &>/dev/null; then
    usermod -L "$user"
    echo "✅ User '$user' berhasil dikunci."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
read -n 1 -s -r -p "Tekan tombol apapun untuk kembali..."
