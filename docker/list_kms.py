import boto3
import os

# Crea el cliente de Secret Manager
client = boto3.client('secretsmanager',
aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'))

# Obtiene el valor secreto para AWS_ACCESS_KEY_ID
secret_value_access_key = client.get_secret_value(SecretId='arn:aws:secretsmanager:us-east-1:658299583140:secret:secretsm_lab_develop__rZ9uTUj3-LKHdC8')['SecretString']
print("Valor de AWS_ACCESS_KEY_ID:", secret_value_access_key)

# Obtiene el valor secreto para AWS_SECRET_ACCESS_KEY
secret_value_secret_key = client.get_secret_value(SecretId='arn:aws:secretsmanager:us-east-1:658299583140:secret:secretsm_lab_develop__rZ9uTUj3-LKHdC8')['SecretString']
print("Valor de AWS_SECRET_ACCESS_KEY:", secret_value_secret_key)

# Obtiene el valor secreto para 'prueba1'
secret_value_prueba1 = client.get_secret_value(SecretId='arn:aws:secretsmanager:us-east-1:658299583140:secret:secretsm_lab_develop__rZ9uTUj3-LKHdC8')['SecretString']
print("Valor de prueba1:", secret_value_prueba1)

#
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