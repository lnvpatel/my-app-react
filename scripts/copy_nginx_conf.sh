#!/bin/bash

# Copy Nginx config to the sites-available directory
rm -rf /etc/nginx
cp -r /var/www/my-app/nginx /etc

# Remove any existing symlink
if [ -L /etc/nginx/sites-enabled/my-app.conf ]; then
    rm /etc/nginx/sites-enabled/my-app.conf
fi

# Create a new symlink in sites-enabled
ln -s /etc/nginx/sites-available/my-app.conf /etc/nginx/sites-enabled/my-app.conf

echo "Nginx configuration copied and symlink created"

