#!/bin/bash
clear
echo -e "====================================="
echo -e "        SSL Certificate Manager"
echo -e "====================================="

DOMAIN=$(cat /etc/xray/domain)
if [[ -z "$DOMAIN" ]]; then
    echo "❌ Domain belum diset di /etc/xray/domain"
    exit 1
fi

echo -e "Domain terdeteksi : \e[1;32m$DOMAIN\e[0m"
echo
echo -e "Pilih penyedia SSL:"
echo -e "1) Let's Encrypt   [Free, Popular]"
echo -e "2) ZeroSSL         [Manual Email API]"
echo -e "3) Buypass Go      [Valid 180 Hari]"
echo -e "4) Google Trust    [Via acme.sh]"
echo -e "5) Exit"
echo -ne "\nPilihan [1-5]: "; read ssl_choice

if [[ ! -d ~/.acme.sh ]]; then
    echo -e "\n🟡 Menginstall acme.sh..."
    curl https://get.acme.sh | sh
    source ~/.bashrc
    ~/.acme.sh/acme.sh --upgrade --auto-upgrade
fi

case $ssl_choice in
    1)
        echo -e "\n🚀 Memproses Let's Encrypt untuk $DOMAIN ..."
        ~/.acme.sh/acme.sh --issue -d $DOMAIN --standalone --keylength ec-256
        ;;
    2)
        echo -e "\n❗ ZeroSSL membutuhkan konfigurasi email + API Key (manual setup)."
        exit 1
        ;;
    3)
        echo -e "\n🚀 Memproses Buypass Go untuk $DOMAIN ..."
        ~/.acme.sh/acme.sh --set-default-ca --server buypass.com
        ~/.acme.sh/acme.sh --issue -d $DOMAIN --standalone --keylength ec-256
        ;;
    4)
        echo -e "\n🚀 Memproses Google Trust untuk $DOMAIN ..."
        ~/.acme.sh/acme.sh --set-default-ca --server google
        ~/.acme.sh/acme.sh --issue -d $DOMAIN --standalone --keylength ec-256
        ;;
    5)
        exit 0
        ;;
    *)
        echo "❌ Pilihan tidak valid!"
        exit 1
        ;;
esac

echo -e "\n📦 Menginstal sertifikat ke /etc/xray/"
~/.acme.sh/acme.sh --install-cert -d $DOMAIN \
--ecc \
--key-file /etc/xray/private.key \
--fullchain-file /etc/xray/cert.crt

echo -e "\n✅ SSL berhasil diinstal!"
systemctl restart nginx 2>/dev/null
systemctl restart xray
