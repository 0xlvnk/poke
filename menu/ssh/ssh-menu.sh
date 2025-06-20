#!/bin/bash
ROOT=$(dirname "$(readlink -f "$0")")/..

while true; do
    clear
    echo -e "\033[1;33m========== SSH MENU ==========\033[0m"
    echo -e "1)  Create SSH Account"
    echo -e "2)  List SSH Member"
    echo -e "3)  Delete SSH Account"
    echo -e "4)  Lock SSH User"
    echo -e "5)  Unlock SSH User"
    echo -e "6)  Extend SSH Expiry"
    echo -e "7)  Check Active SSH & IP Login"
    echo -e "8)  Change SSH Password"
    echo -e "x)  Back"
    echo -ne "\nSelect option: "; read opt

    case $opt in
        1)
            clear
            bash "$ROOT/ssh/create.sh"
            echo -ne "\n\033[1;33mKembali ke menu utama? [Tekan ENTER]\033[0m"
            read
            ;;
        2)
            clear
            bash "$ROOT/ssh/list.sh"
            echo -ne "\n\033[1;33mKembali ke menu utama? [Tekan ENTER]\033[0m"
            read
            ;;
        3) bash "$ROOT/ssh/delete.sh" ;;
        4) bash "$ROOT/ssh/lock.sh" ;;
        5) bash "$ROOT/ssh/unlock.sh" ;;
        6) bash "$ROOT/ssh/extend.sh" ;;
        7) bash "$ROOT/ssh/online.sh" ;;
        8) bash "$ROOT/ssh/passwd.sh" ;;
        x) break ;;
        *) echo -e "❌ Pilihan tidak valid!"; sleep 1 ;;
    esac
done
