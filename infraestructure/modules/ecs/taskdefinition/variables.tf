variable "task_name" {
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

variable "execution_role" {
  description = "the IAM ARN role that ecs task will use to call antoher services in AWS"
  type        = string
}

variable "task_role" {
  description = "the IAM ARN role that ecs task will use to call antoher services in AWS"
  type        = string
}
variable "docker_repo" {
  description = "Docker images"
  type        = string
}
variable "container_port" {
  description = "container_port"
  type        = number
}

 variable "region" {
  description = "Aws Region"
  type        = string
  default     = "us-east-1"  
 }



