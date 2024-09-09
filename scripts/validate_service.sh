#!/bin/bash

# Check if the application is running by querying the server
curl -s http://localhost:8080 > /dev/null

if [ $? -eq 0 ]; then
    echo "Application is running."
    exit 0
else
    echo "Application is not running."
    exit 1
fi
