variable "name" {
  description = "A name for the ecs service"
  type        = string
}

variable "ecs_cluster_id" {
  description = "The ECS cluster ID in which the resources will be created"
  type        = string
}

variable "arn_task_definition" {
  description = "The ARN of the Task Definition to use to deploy the tasks"
  type        = string
}

variable "desired_tasks" {
  description = "The minimun number of tasks to run in the service"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ID in which ecs will deploy the tasks"
  type        = list(string)
}
variable "vpc_id" {
  description = "vpc id"
  type        = string
}
