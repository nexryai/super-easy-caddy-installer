#!/usr/bin/env bash

set -eu

if [ ! -f /etc/.caddyinstalled ]; then
        groupadd --system caddy
        useradd --system \
                --gid caddy \
                --create-home \
                --home-dir /var/lib/caddy \
                --shell /usr/sbin/nologin \
                --comment "Caddy web server" \
                caddy
        touch /etc/.caddyinstalled
fi

wget "https://caddyserver.com/api/download?os=linux&arch=arm64&p=github.com%2Fcaddy-dns%2Fcloudflare" -O /usr/bin/caddy
chmod +x /usr/bin/caddy

cat > "/etc/systemd/system/caddy.service" <<EOF
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512

# Security opts
PrivateDevices=true
PrivateTmp=true
ProtectHome=true
ProtectSystem=full
NoNewPrivileges=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectKernelLogs=true
ProtectControlGroups=true
ProtectHostname=true
RestrictSUIDSGID=true
ProtectClock=true
RestrictRealtime=true
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

# Pelase change if you need
InaccessiblePaths=/boot
InaccessiblePaths=/home

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
touch /etc/Caddyfile

echo "Warning: This script is written with the intention of running Caddy as a reverse proxy server only. If you serve files, please edit /etc/systemd/system/caddy.service to remove some security options!"
