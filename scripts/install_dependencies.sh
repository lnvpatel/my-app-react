# Install necessary system dependencies
echo "Updating system..."
yum update -y

echo "Installing Node.js and npm..."
yum install -y nodejs npm

echo "Creating application directory..."
mkdir -p /var/www/my-app

# Navigate to the project directory (adjust as needed)
cd /var/www/my-app || { echo "Directory /var/www/my-app does not exist. Exiting."; exit 1; }


# Clean npm cache and install dependencies
echo "Cleaning npm cache and installing Node.js dependencies..."
yarn cache clean
rm -rf node_modules
yarn install

# Print a success message
echo "Dependencies installed successfully."
