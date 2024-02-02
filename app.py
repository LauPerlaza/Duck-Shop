from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/buscar', methods=['GET'])
def buscar_patos():
    return 'Hola desde find_ducks api'

if __name__ == '__main__':
    app.run(debug=True)
