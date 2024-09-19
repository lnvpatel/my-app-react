#!/bin/bash

# Variables
HOST="localhost"
PORT=80  # Nginx default port for HTTP
RETRIES=5
SLEEP_TIME=3

# Function to check if Nginx is serving the application
check_nginx() {
    curl -s --head http://$HOST:$PORT | head -n 1 | grep "200 OK" > /dev/null
    return $?
}

echo "Validating if Nginx is serving the application on http://$HOST:$PORT..."

for i in $(seq 1 $RETRIES); do
    if check_nginx; then
        echo "Nginx is serving the application."
        exit 0
    else
        echo "Nginx is not serving the application. Attempt $i/$RETRIES..."
        sleep $SLEEP_TIME
    fi
done

echo "Nginx failed to serve the application after $RETRIES attempts."
exit 1
