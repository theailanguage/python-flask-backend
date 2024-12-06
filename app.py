from flask import Flask, request, jsonify

from endpoints.get_info import get_info
from helpers.options_helper import process_options_response
from middleware.check_api_key import check_api_key

app = Flask(__name__)

@app.before_request
def check_authentication():
    # Handle options request - An OPTIONS request is a method in HTTP that allows a client to determine the communication options for a specific resource or server:
    if request.method == 'OPTIONS':
        return process_options_response()

    # Check if the request path is for the AI update endpoint
    if request.path in ['/v1/getInfo']:
        # Call the check_api_key middleware
        auth_fail_response = check_api_key(request)
    else:
        # Use other authentication checks
        auth_fail_response = check_api_key(request)

    if auth_fail_response:
        print(f"AUTH FAIL {auth_fail_response}")
        return auth_fail_response
    else:
        print("AUTH SUCCESS")  # Return error response if auth fails


# Endpoint to get information
@app.route('/v1/getInfo', methods=['POST', 'OPTIONS'])
def getInfo():
    return get_info(request)  # Call the new update entity function
        
# Endpoint for root
@app.route('/')
def hello_world():
    return '''Hello World! Thanks for pinging us!

You have reached the The AI Language root API. Go to www.theailanguage.com to start building'''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
