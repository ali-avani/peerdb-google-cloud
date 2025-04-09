#!/bin/bash

set -e

echo "=== PeerDB Nginx Setup ==="

read -p "Enter the domain name to use for PeerDB UI (e.g., peerdb.example.com): " DOMAIN

if [[ -z "$DOMAIN" ]]; then
    echo "Error: Domain name cannot be empty."
    exit 1
fi

TEMPLATE_FILE="nginx.conf"
if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: $TEMPLATE_FILE not found in current directory."
    exit 1
fi

if ! command -v nginx >/dev/null 2>&1; then
    echo "Installing Nginx..."
    sudo apt update
    sudo apt install -y nginx
else
    echo "Nginx is already installed."
fi

NGINX_CONFIG_PATH="/etc/nginx/sites-available/peerdb"
sed "s/DOMAIN_PLACEHOLDER/$DOMAIN/g" "$TEMPLATE_FILE" | sudo tee "$NGINX_CONFIG_PATH" >/dev/null

sudo ln -sf "$NGINX_CONFIG_PATH" /etc/nginx/sites-enabled/peerdb

sudo nginx -t && sudo systemctl reload nginx

echo "Nginx has been configured and reloaded."
echo "Visit http://$DOMAIN to access the PeerDB UI."
