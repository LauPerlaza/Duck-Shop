variable "name" {
  description = " A name for Task Definition"
  type        = string
}
variable "cpu" {
  description = "the CPU value to assign to container, read AWS documentation to available values"
  type        = string
}
variable "memory" {
  description = "the MEMORY value to assign to container, read AWS documentation to available values"
  type        = string
}

variable "arn_role" {
  description = "the IAM ARN role that ecs task will use to call antoher services in AWS"
  type        = string
}

variable "task_role" {
  description = "the IAM ARN role that ecs task will use to call antoher services in AWS"
  type        = string
}
variable "registry" {
  description = "images regristry"
  type        = string
}
variable "container_port" {
  description = "container_port"
  type        = string
}

variable "region" {
  description = "Region in which the resources will be deployed"
  type        = string
  default     = "us-east-1"
}
variable "env" {
  type    = string
  default = "develop"
}


