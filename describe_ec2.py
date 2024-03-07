import boto3

# Crea el cliente EC2
ec2 = boto3.client('ec2')

# Obtener información de instancias
response = ec2.describe_instances()

# Iterar sobre las instancias
for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        # Obtiene el ID y el nombre de la instancia (si tiene un nombre)
        instance_id = instance['InstanceId']
        instance_name = next((tag['Value'] for tag in instance.get('Tags', []) if tag['Key'] == 'Name'), '')
        
        # Imprime el ID y el nombre de la instancia
        print(f"Instance ID: {instance_id}, Instance Name: {instance_name}")
