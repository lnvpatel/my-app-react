#!/bin/bash

# Start Nginx service
echo "Starting Nginx..."

# Ensure that Nginx is not already running, stop it if needed
sudo systemctl stop nginx

# Start Nginx
sudo systemctl start nginx

# Check if Nginx started successfully
if systemctl is-active --quiet nginx; then
    echo "Nginx started successfully!"
else
    echo "Failed to start Nginx."
    exit 1
fi
#line added