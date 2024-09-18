echo "Creating application directory..."
mkdir -p /var/www/my-app

# Install Node.js and npm if not already installed
if ! node -v > /dev/null 2>&1; then
    echo "Node.js not found. Installing Node.js..."
    sudo yum install -y nodejs
fi


# Install Nginx if it's not already installed
if ! nginx -v > /dev/null 2>&1; then
    echo "Nginx not found. Installing Nginx..."
    sudo amazon-linux-extras install nginx1.12 -y
    sudo systemctl enable nginx
else
    echo "Nginx is already installed."
fi

# Install Yarn globally if not already installed
if ! yarn -v > /dev/null 2>&1; then
    echo "Yarn not found. Installing Yarn..."
    npm install -g yarn
fi

# Clean existing node_modules, yarn.lock, and build if they exist
echo "Cleaning old dependencies and build..."
rm -rf node_modules
rm -f yarn.lock
rm -rf build

# Install project dependencies
echo "Installing project dependencies..."
yarn install

# Build the application
echo "Building the React application..."
yarn build