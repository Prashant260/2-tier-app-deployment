from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/api/message', methods=['POST'])
def message():
    data = request.get_json()
    user_message = data.get('message')

    response = f"Server received: {user_message}"

    return jsonify({"response": response})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)