from flask import jsonify

def process_options_response():
    # Corrected CORS preflight response
    response = jsonify({})  # Create an empty response
    response.status_code = 204
    return add_options_headers(response)

def add_options_headers(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Authorization, Content-Type')
    response.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS')
    return response