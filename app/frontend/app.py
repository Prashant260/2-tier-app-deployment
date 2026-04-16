from flask import Flask, render_template
import requests

app = Flask(__name__)

BACKEND_URL = "http://localhost:5000/api/data"

@app.route('/')
def home():
    try:
        response = requests.get(BACKEND_URL)
        data = response.json()
        message = data.get("message")
    except:
        message = "Backend not reachable ❌"

    return render_template("index.html", message=message)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
