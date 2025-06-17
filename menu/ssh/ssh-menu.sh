#!/bin/bash
ROOT=$(dirname "$(readlink -f "$0")")/..
source "$ROOT/utils/menu-header.sh"

while true; do
    clear
    print_header "SSH WEBSOCKET MENU"
    echo -e "[1]  Create SSH Websocket Account"
    echo -e "[2]  List SSH Member"
    echo -e "[3]  Delete SSH Account"
    echo -e "[4]  Lock SSH User"
    echo -e "[5]  Unlock SSH User"
    echo -e "[6]  Extend SSH Expiry"
    echo -e "[7]  Check Active SSH & IP Login"
    echo -e "[8]  Change SSH Password"
    echo -e "[0]  Back to Main Menu"
    echo -e "[x]  Exit"
    echo -ne "\\nSelect menu: "; read opt

    case $opt in
        1) bash "$ROOT/ssh/create.sh" ;;
        2) bash "$ROOT/ssh/list.sh" ;;
        3) bash "$ROOT/ssh/delete.sh" ;;
        4) bash "$ROOT/ssh/lock.sh" ;;
        5) bash "$ROOT/ssh/unlock.sh" ;;
        6) bash "$ROOT/ssh/extend.sh" ;;
        7) bash "$ROOT/ssh/online.sh" ;;
        8) bash "$ROOT/ssh/passwd.sh" ;;
        0) bash "$ROOT/menu.sh"; break ;;
        x) exit ;;
        *) echo -e "❌ Pilihan tidak valid!"; sleep 1 ;;
    esac
done
