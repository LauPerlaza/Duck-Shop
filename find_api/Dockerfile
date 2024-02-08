# Usa una imagen de Python desde Docker Hub.
FROM python:3.9-slim

# Establece el directorio de trabajo en app.
WORKDIR /app

# Copia el archivo requirements.txt al contenedor.
COPY requirements.txt .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de la aplicación al contenedor.
COPY . .

# Expone el puerto en el que la aplicación se ejecutará.
EXPOSE 5000

# Comando para ejecutar la aplicación 
CMD ["python", "app.py"]
