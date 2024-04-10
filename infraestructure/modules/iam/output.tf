output "arn_executionrole" {
    value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "execution_role" {
  value = aws_iam_role.ecsTaskExecutionRole.name
}

output "arn_role" {
    value = aws_iam_role.TaskRole.arn
}

output "name_role" {
  value = aws_iam_role.TaskRole.name
}