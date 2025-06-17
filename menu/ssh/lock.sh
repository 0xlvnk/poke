#!/bin/bash
read -rp "Username yang ingin dikunci: " user
if id "$user" &>/dev/null; then
    usermod -L "$user"
    echo "✅ User '$user' berhasil dikunci (tidak bisa login)."
else
    echo "❌ User '$user' tidak ditemukan!"
fi
