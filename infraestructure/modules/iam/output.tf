output "arn_role" {
  value = aws_iam_role.ecs_role.arn
}

output "name_role" {
  value = aws_iam_role.ecs_role.name
}
