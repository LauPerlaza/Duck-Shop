variable "name_role" {
  description = "Name for the IAM Role"
  type        = string
}

variable "attach_to" {
  description = "the arn or role name to attach the policy created"
  type        = string
  default     = ""
}

