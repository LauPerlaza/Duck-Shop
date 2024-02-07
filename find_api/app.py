from flask import Flask, request

app = Flask(__name__)

@app.route('/buscar', methods=['GET'])
def buscar_patos():
    # Obtiene valores de los parámetros en la URL
    color = request.args.get('color', 'sin color')
    nombre = request.args.get('nombre', 'sin nombre')

    # Imprime los valores en la consola
    print(f"Color: {color}, Nombre: {nombre}")

    # Construye el mensaje de respuesta
    mensaje = f"El pato que se busca es de color {color}"
    if nombre != 'sin nombre':
        mensaje += f" y se llama {nombre}"

    return mensaje

if __name__ == '__main__':
    app.run(debug=True)
