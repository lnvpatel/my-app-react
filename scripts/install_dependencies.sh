#!/bin/bash

# Create the deployment directory if it doesn't exist
if [ ! -d /var/www/my-app ]; then
  mkdir -p /var/www/my-app
  echo "Directory /var/www/my-app created"
fi

#!/bin/bash

# Path to deployment root (contains directories named by deployment group ID)
deployment_root="/path/to/deployment-root"  # Update this path

# Temporary directory for the current deployment
tmp_dir="/tmp/deployment-emp"

# Ensure the temporary directory exists
mkdir -p $tmp_dir

# Navigate to the deployment root
cd $deployment_root || exit 1

# Find the deployment group ID directory
for group_dir in */; do
    # Skip non-directory entries
    if [[ ! -d "$group_dir" ]]; then
        continue
    fi

    # Navigate to the deployment group directory
    cd "$group_dir" || continue

    # Clean up old deployment ID directories
    for deployment_dir in */; do
        # Skip non-directory entries
        if [[ ! -d "$deployment_dir" ]]; then
            continue
        fi

        # Delete all old deployment directories except the one currently being used
        if [[ "$deployment_dir" != "*/" ]]; then
            rm -rf "$deployment_dir"
        fi
    done

    # Return to the deployment root
    cd "$deployment_root" || exit 1
done

# Extract the new bundle
echo "Extracting the new bundle..."
tar -xvf $tmp_dir/bundle.tar -C $tmp_dir

# Move the new deployment to the application path
echo "Deploying new version..."
rm -rf /var/www/my-app  # Adjust as necessary
mv $tmp_dir/* /var/www/my-app  # Adjust as necessary

# Clean up the temporary directory
rm -rf $tmp_dir

echo "Deployment complete."


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
yarn install --production
