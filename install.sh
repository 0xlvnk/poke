#!/bin/bash
clear
echo -e "====================================="
echo -e " 🔧 VPS MENU INSTALLER by Kalvin"
echo -e "====================================="

# Update & install dependencies
apt update && apt upgrade -y
apt install -y curl wget screen cron unzip

# Copy folder menu ke /root/menu
rm -rf /root/menu
cp -r menu /root/menu

# Set permission
chmod +x /root/menu/*.sh
chmod +x /root/menu/*/*.sh
chmod +x /root/menu/*/*/*.sh

# Buat agar cukup ketik `menu`
ln -sf /root/menu/menu.sh /usr/bin/menu
chmod -R +x /root/menu

# Auto generate domain acak (bisa diubah nanti lewat menu domain)
RANDOM_DOMAIN="vps-$(date +%s | sha256sum | head -c 6).exampledomain.com"
mkdir -p /etc/xray
echo "$RANDOM_DOMAIN" > /etc/xray/domain
echo "✅ Domain default: $RANDOM_DOMAIN"
echo "⚠️  Ganti domain kamu di menu [10] jika ingin pakai domain sendiri"

# Tambah info awal login
cat > /root/menu/utils/info.sh << 'EOF'
#!/bin/bash
clear

# Hitung akun dari database
if [[ -f /etc/ssh-db/users.db ]]; then
    ssh_count=$(wc -l < /etc/ssh-db/users.db)
else
    ssh_count=0
fi

echo -e "••••• MEMBER INFORMATION •••••"
echo -e "SSH Account     : \$ssh_count"
echo -e "Vmess Account   : 0"
echo -e "Vless Account   : 0"
echo -e "Trojan Account  : 0"
echo
echo -e "••••• SCRIPT INFORMATION •••••"
echo -e "Owner  : Kalvin"
echo -e "User   : \$(whoami)"
echo -e "ISP    : \$(curl -s ipinfo.io/org | cut -d ' ' -f2-)"
echo -e "Region : \$(curl -s ipinfo.io/city)/\$(curl -s ipinfo.io/country)"
EOF
chmod +x /root/menu/utils/info.sh


# Tambahkan pemanggil info ke menu utama
sed -i '1i bash /root/menu/utils/info.sh' /root/menu/menu.sh

# Tambahkan ke bashrc agar muncul saat login
if ! grep -q "menu" ~/.bashrc; then
    echo "menu" >> ~/.bashrc
fi

echo -e "\n✅ Install selesai! Ketik 'menu' untuk mulai."
