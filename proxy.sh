#!/bin/bash

PROJECT_DIR="."
VENV_DIR="$PROJECT_DIR/venv"
APP_SCRIPT="$PROJECT_DIR/proxy-app.py"
PID_FILE="$PROJECT_DIR/proxy_app.pid"

set -a
source "$PROJECT_DIR/.env"
set +a

start_app() {
    if [ -f "$PID_FILE" ]; then
        echo "Proxy app is already running (PID: $(cat $PID_FILE))"
    else
        echo "Starting proxy app..."
        source "$VENV_DIR/bin/activate"

        echo "Opening port $APP_PORT..."
        ufw allow "$APP_PORT/tcp"
        
        nohup python "$APP_SCRIPT" > "$PROJECT_DIR/proxy_app.log" 2>&1 &
        echo $! > "$PID_FILE"
        echo "Proxy app started with PID: $(cat $PID_FILE)"
        deactivate
    fi
}

# Function to stop the Flask proxy app
stop_app() {
    if [ -f "$PID_FILE" ]; then
        echo "Stopping proxy app..."
        kill -9 $(cat "$PID_FILE")
        rm -f "$PID_FILE"
        echo "Proxy app stopped."

        echo "Closing port $APP_PORT..."
        ufw deny "$APP_PORT/tcp"
    else
        echo "Proxy app is not running."
    fi
}

# Check the input argument to start or stop the app
case "$1" in
    start)
        start_app
        ;;
    stop)
        stop_app
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac
