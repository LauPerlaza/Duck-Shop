# Terraform Module to create IAM Role and Policy
# ECS Role Creation For ECS

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.name_role}"
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
    Name = "${var.name_role}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Custom ReadOnly Policy for Ec2 and VPC
resource "aws_iam_policy" "ec2_vpc_read_only_policy" {
  name               = "${var.name_policy}"
  description = "Permisos de lectura para Ec2 y VPC"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          # EC2 Read Only Actions
          "ec2:Describe*",
          # VPC Read Only Actions
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeRouteTables",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeVpnConnections",
          "ec2:DescribeVpnGateways",
        ],
        Resource = "*"
      }
    ]
  })
}

# Attachment of the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecsTaskExecutionRole.name

  lifecycle {
    create_before_destroy = true
  }
}

# Attachment of the EC2 and VPC ReadOnly Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "ec2_vpc_read_only_policy_attachment" {
  policy_arn = aws_iam_policy.ec2_vpc_read_only_policy.arn
  role = aws_iam_role.ecsTaskExecutionRole.name

  lifecycle {
    create_before_destroy = true
  }
}

