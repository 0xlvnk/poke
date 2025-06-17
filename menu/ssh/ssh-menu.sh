#!/bin/bash
ROOT=$(dirname "$(readlink -f "$0")")/..
source "$ROOT/utils/menu-header.sh"

while true; do
    clear
    print_header "SSH MENU"
    echo -e "[1]  Create SSH Account"
    echo -e "[2]  List SSH Member"
    echo -e "[3]  Delete SSH Account"
    echo -e "[4]  Lock SSH User"
    echo -e "[5]  Unlock SSH User"
    echo -e "[6]  Extend SSH Expiry"
    echo -e "[7]  Check Active SSH & IP Login"
    echo -e "[8]  Change SSH Password"
    echo -e "[x]  Back"
    echo -ne "\\nSelect option: "; read opt

    case $opt in
        1) clear; bash "$ROOT/ssh/create.sh"; read -n1 -r -p "Press any key to return..." ;;
        2) clear; bash "$ROOT/ssh/list.sh"; read -n1 -r -p "Press any key to return..." ;;
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
