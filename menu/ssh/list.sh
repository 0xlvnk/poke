#!/bin/bash
clear
echo -e "\033[1;36m======= DAFTAR AKUN SSH =======\033[0m"
printf "%-15s %-15s\n" "Username" "Expired Date"
echo "-------------------------------"

count=0
db_file="/etc/ssh-db/users.db"

if [[ -f $db_file ]]; then
    while IFS='|' read -r user pass exp owner limit; do
        [[ -z "$user" || -z "$exp" ]] && continue
        printf "%-15s %-15s\n" "$user" "$exp"
        ((count++))
    done < "$db_file"

    echo "-------------------------------"
    echo -e "Total Akun SSH: $count"
else
    echo "Belum ada akun yang dibuat."
fi
