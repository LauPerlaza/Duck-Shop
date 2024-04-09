import boto3

# Crea el cliente de EC2 sin especificar las credenciales
ec2_client = boto3.client('ec2', region_name="us-west-1")

# Obtiene la lista de todas las VPCs
vpcs_response = ec2_client.describe_vpcs()
vpcs = vpcs_response['Vpcs']

# Imprime información sobre todas las VPCs disponibles
print("Lista de VPCs disponibles:")
for vpc in vpcs:
    print("VPC ID:", vpc['VpcId'])
    print("CIDR Block:", vpc['CidrBlock'])