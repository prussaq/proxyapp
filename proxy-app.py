from flask import Flask, request, jsonify
import requests
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

PROXY_KEY = os.getenv('PROXY_KEY')
APP_PORT = os.getenv('APP_PORT')

@app.route('/proxy', methods=['POST'])
def proxy():
    proxy_key = request.headers.get('X-PROXY-KEY')
    if proxy_key != PROXY_KEY:
    	return jsonify({'error': 'Unauthorized access'}), 401
    
    try:
        # Get the JSON data from the incoming request
        req_data = request.json
        
        # Extract the required fields
        method = req_data.get('method').upper()
        url = req_data.get('url')
        data = req_data.get('data', {})

        # Dispatch the request based on the method
        if method == 'GET':
            response = requests.get(url)
        elif method == 'POST':
            response = requests.post(url, json=data)
        elif method == 'PUT':
            response = requests.put(url, json=data)
        elif method == 'DELETE':
            response = requests.delete(full, json=data)
        else:
            return jsonify({'error': 'Unsupported HTTP method'}), 400

        # Return the response from the proxied request
        return jsonify(response.json()), response.status_code

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(APP_PORT))
