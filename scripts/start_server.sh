#!/bin/bash

# Navigate to the directory where your build files are located
cd /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_ID/deployment-archive

# Start the server in the background
# Start the server and bind it to all network interfaces
serve -p 8080 --listen 0.0.0.0 . &

# Optional: Log output
echo "Application started successfully!" >> /tmp/start_server.log
