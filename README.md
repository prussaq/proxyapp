# Flask Proxy App

## Overview

This project is a simple Flask-based proxy server that forwards API requests.

## Prerequisites

1. GNU/Linux (running on Ubuntu 24.04 LTS)
2. Python 3.x
3. ufw installed and configured
4. Run by root or user allowed to use ufw

## Instructions

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/prussaq/proxyapp.git

2. **Create a Virtual Environment:**

   ```bash
   python3 -m venv venv

   source venv/bin/activate

   python3 -m install flask requests python-dotenv

3. **Create the `.env` File:**

   ```bash
   touch .env

   Add the following content:

   # .env file
   PROXY_KEY=your_proxy_key_here
   APP_PORT=your_app_port_here

4. **Usage:**

   ```bash
   ./proxy.sh start
   ./proxy.sh stop

5. **Accessing the Proxy:**

   **URL:**
   
   `http://your-vps-ip:your-app-port/proxy`

   **Method:**
   
   `POST`

   **Headers:**

   `X-PROXY-KEY: your-proxy-key`

   **JSON:**

   ```json
   {
    "method": "GET",
    "url": "https://api.example.com?param1=value",
    "data": {}
   }

## File Structure
```
proxyapp/
│
├── .env              # Environment variables
├── proxy_app.py      # Your Python script
├── proxy.sh          # Bash script to manage the app
├── README.md         # Project documentation
├── .gitignore        # Git ignore file
└── requirements.txt  # Python dependencies (generated via pip freeze)

