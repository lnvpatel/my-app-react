#!/bin/bash

# Validate that the application is running
echo "Validating service..."

# Check if the application is running on port 8080
if curl -s http://localhost:8080 > /dev/null; then
  echo "Application is running successfully."
  exit 0
else
  echo "Application is not running."
  exit 1
fi
