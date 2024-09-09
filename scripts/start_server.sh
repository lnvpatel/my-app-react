#!/bin/bash

# Start the application
echo "Starting application..."

# Navigate to the directory where the built React application is located
cd /var/www/my-app || { echo "Directory /var/www/my-app does not exist. Exiting."; exit 1; }

# Start the application using serve
serve -s build -l 8080