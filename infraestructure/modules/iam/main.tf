# Terraform Module to create IAM Role and Policy
# ECS Role Creation For ECS

resource "aws_iam_role" "ecs_role" {
  name               = "${var.name}"
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
    Name = "ECS-ROLE-${var.name}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Attachment of the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attachment_to_role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  role       = aws_iam_role.ecs_role.name

  lifecycle {
    create_before_destroy = true
  }
}

