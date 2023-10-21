# super-easy-caddy-installer
Caddy + caddy-dns/cloudflare plugin + secure systemd service file

```
# amd64
curl https://raw.githubusercontent.com/nexryai/super-easy-caddy-installer/main/amd64.sh | sudo bash

# arm64 (Such as rpi4+)
curl https://raw.githubusercontent.com/nexryai/super-easy-caddy-installer/main/arm64.sh | sudo bash

# Edit Caddyfile (default is empty)
sudo nano /etc/Caddyfile

# Enable and Start daemon
sudo systemctl enable --now caddy
```

## Example of Caddyfile when using cloudflare
```
# Use cloudflare origin certs
my.ultimate.website.example.org {
        # Path to cloudflare origin certs (https://developers.cloudflare.com/ssl/origin-configuration/origin-ca/)
        tls /etc/ssl/certs/example.pem /etc/ssl/private/example.pem
        encode zstd gzip
        reverse_proxy 127.0.0.1:3000
}

# Use Let's encrypt's certs with Cloudflare's DNS challenges
my.super.ultimate.website.example.org {
        tls {
                dns cloudflare CLOUDFLARE_API_TOKEN_WITH_PERMISSION_OF_EDIT_DNS_RECORDS
        }
        reverse_proxy 192.168.5.200:3000
}
```
