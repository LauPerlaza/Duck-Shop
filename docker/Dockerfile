FROM python:3.8

WORKDIR /app

# Copia el archivo de código de Python y el archivo .env al contenedor.
COPY list_ec2.py .
COPY .env .

# Instala las dependencias del código.
RUN pip install boto3 python-dotenv

# Comando a ejecutar cuando se inicie el contenedor
CMD ["python", "list_ec2.py"]
