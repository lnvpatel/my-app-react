#!/bin/bash

# Navigate to the directory where your build files are located
cd /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_ID/deployment-archive

# Start the server in the background
# Start the server and bind it to all network interfaces
#!/bin/bash
# Start the server using serve and run it in the background

serve -s . -p 8080 >> /tmp/start_server.log 2>&1 &


# Optional: Log output
echo "Application started successfully!" >> /tmp/start_server.log
