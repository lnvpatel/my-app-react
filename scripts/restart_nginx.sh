#!/bin/bash

# Restart or reload Nginx to apply changes
echo "Reloading Nginx..."
systemctl reload nginx

if [ $? -eq 0 ]; then
    echo "Nginx reloaded successfully."
else
    echo "Failed to reload Nginx. Restarting Nginx instead."
    systemctl restart nginx
fi
#line added