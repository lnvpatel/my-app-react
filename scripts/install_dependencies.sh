#!/bin/bash

# Create the deployment directory if it doesn't exist
if [ ! -d /var/www/my-app ]; then
  mkdir -p /var/www/my-app
  echo "Directory /var/www/my-app created"
fi

# Check if Nginx is installed
if ! nginx -v >/dev/null 2>&1; then
  echo "Nginx not found. Installing Nginx..."
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "amzn" && "$VERSION_ID" == "2" ]]; then
      sudo amazon-linux-extras install nginx1 -y
    else
      sudo yum install nginx -y
    fi
  else
    echo "OS version not supported for automatic Nginx installation."
  fi
  sudo systemctl enable nginx
  sudo systemctl start nginx
else
  echo "Nginx is already installed."
fi

# Install Yarn if not found
if ! command -v yarn >/dev/null 2>&1; then
  echo "Yarn not found. Installing Yarn..."
  npm install -g yarn
fi

# Clean old dependencies and build
echo "Cleaning old dependencies and build..."
rm -rf /var/www/my-app/node_modules /var/www/my-app/build

# Change to project directory
cd /var/www/my-app

# Debug: List contents
echo "Contents of /var/www/my-app:"
ls -la

# Install dependencies
echo "Installing project dependencies..."
yarn install

# Build the React application
echo "Building the React application..."
yarn run build
