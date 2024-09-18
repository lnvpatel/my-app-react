#!/bin/bash

# Copy the custom nginx.conf to the appropriate location
echo "Copying custom Nginx configuration..."
cp -r /var/www/my-app/nginx /etc

if [ $? -eq 0 ]; then
    echo "Nginx configuration copied successfully."
else
    echo "Failed to copy Nginx configuration."
    exit 1
fi
