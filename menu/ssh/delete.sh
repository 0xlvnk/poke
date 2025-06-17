#!/bin/bash
read -rp "Username yang ingin dihapus: " user
if id "$user" &>/dev/null; then
    userdel "$user"
    echo "✅ User '$user' telah dihapus."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
read -n 1 -s -r -p "Tekan tombol apapun untuk kembali..."
