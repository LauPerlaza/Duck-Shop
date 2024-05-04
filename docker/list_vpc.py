import boto3
import os

# Crea el cliente de Secret Manager
client = boto3.client('secretsmanager',
aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'))

# Obtiene el valor secreto 
secret_value = client.get_secret_value(SecretId='mi-secret')['SecretString']

# Imprime el valor secreto
print(secret_value)


#////
# Crea el cliente de EC2 sin especificar las credenciales
#ec2_client = boto3.client('ec2', region_name="us-west-1")

# Obtiene la lista de todas las VPCs
#vpcs_response = ec2_client.describe_vpcs()
#vpcs = vpcs_response['Vpcs']

# Imprime información sobre todas las VPCs disponibles
#print("Lista de VPCs disponibles:")
#for vpc in vpcs:
#    print("VPC ID:", vpc['VpcId'])
#    print("CIDR Block:", vpc['CidrBlock'])
#//