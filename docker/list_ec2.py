import boto3
from dotenv import load_dotenv
import os

# Carga las variables de entorno desde el archivo .env
load_dotenv()

# Crea el cliente de EC2 usando las credenciales de las variables de entorno
# Utiliza las del usuario que creó en IAM
ec2_client = boto3.client(
    'ec2',
    aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
    aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'),
    region_name="us-west-2"
)

# Obtiene la lista de todas las VPCs
vpcs_response = ec2_client.describe_vpcs()
vpcs = vpcs_response['Vpcs']

# Imprime información sobre todas las VPCs disponibles
print("Lista de VPCs disponibles:")
for vpc in vpcs:
    print("VPC ID:", vpc['VpcId'])
    print("CIDR Block:", vpc['CidrBlock'])
    print("------------------------------------------")

# Solicita al usuario que ingrese la ID de la VPC que desea listar instancias
vpc_id = input("Ingrese la ID de la VPC que desea listar instancias: ")

# Lista las instancias en la VPC especificada
instances_response = ec2_client.describe_instances(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])

# Imprime información sobre las instancias en la VPC seleccionada
print("\nInstancias en la VPC con ID", vpc_id, ":")
for reservation in instances_response['Reservations']:
    for instance in reservation['Instances']:
        print('ID de la instancia:', instance['InstanceId'])
        print('Tipo de instancia:', instance['InstanceType'])
        print('Estado de la instancia:', instance['State']['Name'])

# Describe las instancias
response = ec2_client.describe_instances()
print('Instancias de EC2:', response['Reservations'])

# Describe las zonas de disponibilidad
ec2 = boto3.client('ec2')
response = ec2.describe_availability_zones()
print('Availability Zones:', response['AvailabilityZones'])

