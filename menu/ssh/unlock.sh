#!/bin/bash
read -rp "Username yang ingin dibuka: " user
if id "$user" &>/dev/null; then
    usermod -U "$user"
    echo "✅ User '$user' berhasil dibuka (bisa login kembali)."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
