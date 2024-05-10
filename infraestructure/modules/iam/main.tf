# Terraform Module to create IAM Role and Policy
# ECS Role Creation For ECS

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "TaskExecution-${var.name_role}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Name = "TaskExecution-${var.name_role}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# 
resource "aws_iam_policy" "get_secrets_policy" {
  name        = "get_policy_${var.name_role}"
  description = "Permite a las task de ECS acceder a los secretos"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
     {
       "Effect": "Allow",
       "Action": [
         "secretsmanager:GetSecretValue",
         "kms:Descrypt"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
  })
}

# Attachment of the policy to the IAM role
resource "aws_iam_role_policy_attachment" "TaskExecutionRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecsTaskExecutionRole.name

  lifecycle {
    create_before_destroy = true
  }
}

# Attachment of the secretsmanager policy to the IAM Role
resource "aws_iam_role_policy_attachment" "get_secrets_policy_attachment" {
  policy_arn = aws_iam_policy.get_secrets_policy.arn
  role = aws_iam_role.ecsTaskExecutionRole.name

  lifecycle {
    create_before_destroy = true
  }
}



