import boto3
from dotenv import load_dotenv
import os

# Carga las variables de entorno desde el archivo .env
load_dotenv()

def obtener_detalles_todas_instancias():
    try:
        # Crea el cliente de EC2 usando las credenciales de las variables de entorno
        # Utiliza las del usuario que creó en IAM
        ec2_client = boto3.client(
            'ec2',
            aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
            aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY')
        )

        # Describe todas las instancias
        response = ec2_client.describe_instances()

        # Obtiene detalles específicos de las instancias
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instance_id = instance['InstanceId']

                # Obtiene el nombre de la instancia si está disponible
                instance_name = ""
                for tag in instance.get('Tags', []):
                    if tag['Key'] == 'Name':
                        instance_name = tag['Value']
                        break

                print(f"ID de la instancia: {instance_id}, Nombre: {instance_name}")

    except Exception as e:
        print(f"Error al obtener instancias: {e}")

if __name__ == "__main__":
    # Llama a la función para obtener detalles de todas las instancias
    obtener_detalles_todas_instancias()