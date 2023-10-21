# super-easy-caddy-installer
Caddy + caddy-dns/cloudflare plugin + secure systemd service file

```
# amd64
curl https://raw.githubusercontent.com/nexryai/super-easy-caddy-installer/main/amd64.sh | sudo bash

# arm64 (Such as rpi4+)
curl https://raw.githubusercontent.com/nexryai/super-easy-caddy-installer/main/arm64.sh | sudo bash

# Edit Caddyfile (default is empty)
sudo nano /etc/Caddyfile
```

## Example of Caddyfile
```
my.ultimate.website.example.org {
        # Path to cloudflare origin certs (https://developers.cloudflare.com/ssl/origin-configuration/origin-ca/)
        tls /etc/ssl/certs/example.pem /etc/ssl/private/example.pem
        encode zstd gzip
        reverse_proxy 127.0.0.1:3000
}
```
