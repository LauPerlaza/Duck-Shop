#   #   # Terraform Code to create AWS Secret manager 

resource "aws_secretsmanager_secret" "secret_manager" {
  name = var.name
  description = "Almacena claves API seguras"

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.name
  }
}