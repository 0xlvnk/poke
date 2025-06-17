#!/bin/bash
clear
echo -e "====================================="
echo -e " 🔧 VPS MENU INSTALLER by Kalvin"
echo -e "====================================="

# Update & install dependencies
apt update && apt upgrade -y
apt install -y curl wget screen cron unzip socat gnupg2 ca-certificates lsb-release \
  iptables software-properties-common dropbear stunnel4 fail2ban vnstat squid

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

# Buat direktori database akun SSH
mkdir -p /etc/ssh-db
touch /etc/ssh-db/users.db

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

# ===== SERVICE SETUP =====

# Enable & start default system services
for svc in dropbear stunnel4 cron vnstat fail2ban squid; do
    systemctl enable $svc
    systemctl start $svc
done

# Install & aktifkan XRAY
if [[ ! -f /usr/local/bin/xray ]]; then
    curl -o xray.zip -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
    unzip xray.zip -d /usr/local/bin/
    chmod +x /usr/local/bin/xray
    rm xray.zip
fi

cat > /etc/systemd/system/xray.service << EOF
[Unit]
Description=Xray Service
After=network.target nss-lookup.target

[Service]
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
LimitNOFILE=51200

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl enable xray
systemctl start xray

# Setup dropbear-ws (WebSocket Dropbear)
cat > /etc/systemd/system/dropbear-ws.service << EOF
[Unit]
Description=Dropbear WebSocket Server
After=network.target

[Service]
ExecStart=/usr/bin/ssh -i /bin/bash -c 'socat TCP-LISTEN:80,fork,reuseaddr TCP:127.0.0.1:22'
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl enable dropbear-ws
systemctl start dropbear-ws

# Pasang binary udp-custom
cd /usr/local/bin
wget -qO udp-custom https://github.com/ardzz/udp-custom/releases/latest/download/udp-custom-linux-amd64
chmod +x udp-custom

# Buat service systemd
cat > /etc/systemd/system/udp-custom.service << EOF
[Unit]
Description=UDP Custom Service by Kalvin
After=network.target

[Service]
ExecStart=/usr/local/bin/udp-custom server --listen 5300 --proxy-proto
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Aktifkan service
systemctl daemon-reexec
systemctl enable udp-custom
systemctl start udp-custom


# ==========================

echo -e "\n✅ Install selesai! Ketik 'menu' untuk mulai."
