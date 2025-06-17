#!/bin/bash
source /root/menu/utils/menu-header.sh

clear
print_header "VPS MENU"

echo -e "1)  SSH Menu"
echo -e "2)  Vmess Menu"
echo -e "3)  Vless Menu"
echo -e "4)  Trojan Menu"
echo -e "5)  Banner SSH"
echo -e "6)  Running Status"
echo -e "7)  Restart Program"
echo -e "8)  Speedtest VPS"
echo -e "10) Domain Menu"
echo -e "11) Backup Menu"
echo -e "x)  Exit"

echo -ne "\nSelect menu: "; read menu

case $menu in
    1) bash /root/menu/ssh/ssh-menu.sh ;;
    2) bash /root/menu/vmess/create.sh ;;
    3) echo "Vless Menu (coming soon)" ;;
    4) echo "Trojan Menu (coming soon)" ;;
    5) bash /root/menu/utils/set-banner.sh ;;
    6) ss -tunlp | less ;;
    7) systemctl restart ssh && echo "SSH Restarted" ;;
    8) speedtest-cli ;;
    10) echo "Domain Menu (coming soon)" ;;
    11) echo "Backup Menu (coming soon)" ;;
    x) exit ;;
    *) echo "Invalid menu"; sleep 1 ;;
esac
