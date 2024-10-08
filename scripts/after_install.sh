#!/bin/bash

# Change Working Directory
cd /home/ec2-user/server4 || exit 1

# Remove Unused Code
echo "Removing node_modules and build directories..."
rm -rf node_modules
rm -rf build

# Increase Node.js memory and install node_modules
echo "Installing node_modules with increased memory limit..."
node --max-old-space-size=4096 $(which npm) install || { echo "npm install failed"; exit 1; }

# Ensure react-scripts is installed if not already
if ! command -v react-scripts &> /dev/null; then
  echo "react-scripts not found, installing..."
  npm install react-scripts --save || { echo "Failed to install react-scripts"; exit 1; }
fi

# Build React App
echo "Building React app..."
npm run build || { echo "React build failed"; exit 1; }

echo "Deployment script executed successfully."
