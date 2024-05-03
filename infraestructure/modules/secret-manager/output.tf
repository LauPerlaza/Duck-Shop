output "secret_arn" {
  value = aws_secretsmanager_secret.secret_manager.arn
}

output "secret_id" {
  value = aws_secretsmanager_secret.secret_manager.id
}