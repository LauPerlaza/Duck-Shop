output "arn_role" {
    value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "name_role" {
  value = aws_iam_role.ecsTaskExecutionRole.name
}
