#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
ROOT=$(dirname "$DIR")
source "$ROOT/utils/menu-header.sh"

# Load Domain dari file yang akan di-set via menu domain (misalnya menu 10)
if [[ -f /etc/xray/domain ]]; then
    DOMAIN=$(cat /etc/xray/domain)
else
    DOMAIN="(Domain belum diset)"
fi

# Deteksi ISP dan Lokasi otomatis dari VPS
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
REGION=$(curl -s ipinfo.io/country)

# Input akun dari user
read -rp "Username      : " user
read -rp "Password      : " pass
read -rp "Expired (days): " exp

# Buat user SSH
useradd -e $(date -d "$exp days" +"%Y-%m-%d") -s /bin/false -M "$user"
echo -e "$pass\n$pass" | passwd "$user" &>/dev/null
exp_date=$(date -d "$exp days" +"%b %d, %Y")

# Output hasil
clear
print_header "Detail SSH  Account"
echo -e "Domain        : $DOMAIN"
echo -e "Username      : $user"
echo -e "Password      : $pass"
echo -e "========================"
echo -e "ISP           : $ISP"
echo -e "Region        : $REGION"
echo -e "========================"
echo -e "Port HTTPS    : 443,8443,2083,2053,2095"
echo -e "Port HTTP     : 80,8880,8080,2082,2096"
echo -e "Port TLS/SSL  : 222,777"
echo -e "Port Dropbear : 109,143,69"
echo -e "Port UDP      : 1-65535"
echo -e "UDPGW         : 7100-7300"
echo -e "========================"
echo -e "Exp           : $exp_date"
echo -e "========================"
