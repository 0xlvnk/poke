#!/bin/bash
clear
echo -e "====== List Akun SSH ======"
printf "%-15s %-10s %-12s %-10s\n" "Username" "Password" "Expired" "Limit"
echo "--------------------------------------------"

count=0

if [[ -f /etc/ssh-db/users.db ]]; then
    while IFS='|' read -r user pass exp owner limit; do
        printf "%-15s %-10s %-12s %-10s\n" "$user" "$pass" "$exp" "$limit"
        ((count++))
    done < /etc/ssh-db/users.db

    echo "--------------------------------------------"
    echo -e "Total Akun SSH: $count"
else
    echo "Belum ada akun yang dibuat."
fi
