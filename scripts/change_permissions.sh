#!/bin/bash

# Configure server settings
echo "Configuring server..."

# Set ownership to nginx user and group
chown -R nginx:nginx /var/www/my-app

# Set permissions
chmod -R 755 /var/www/my-app

# Example: Environment variable setup (optional)
export NODE_ENV=production

echo "Server configuration completed."
