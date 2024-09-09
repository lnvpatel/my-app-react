#!/bin/bash

# Configure server settings (if needed)
echo "Configuring server..."

# Example: Setting permissions
chown -R www-data:www-data /var/www/my-app
chmod -R 755 /var/www/oriserve_react/my-app

# Example: Environment variable setup (replace with actual values)
export NODE_ENV=production