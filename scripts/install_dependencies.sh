#!/bin/bash

# Install necessary system dependencies
echo "Updating system..."
yum update -y

echo "Installing Node.js and npm..."
yum install -y nodejs npm

echo "Creating application directory..."
mkdir -p /var/www/my-app

# Navigate to the builds directory
echo "Navigating to the builds directory..."
cd /var/www/my-app || { echo "Directory /var/www/my-app does not exist. Exiting."; exit 1; }

# Clean npm cache and install dependencies
echo "Cleaning npm cache and installing Node.js dependencies..."
npm cache clean --force
rm -rf node_modules
npm install