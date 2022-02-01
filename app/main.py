from flask import Flask, render_template
import json

app = Flask(__name__)
@app.route('/', methods=['GET', 'HEAD',])
def hello_world():
  return render_template('index.html'), 200


@app.route('/api2', methods=['POST', 'GET',])
def api_json():
  json_response = {"server_status":201, "description": "Hello from polyPY",}
  return json.dumps(json_response, indent=2), 201, {'Content-Type': 'application/json'} 

if __name__ == '__main__':
  app.run(debug=True, host='0.0.0.0') #5000