output "arn_executionrole" {
    value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "execution_role" {
  value = aws_iam_role.ecsTaskExecutionRole.name
}