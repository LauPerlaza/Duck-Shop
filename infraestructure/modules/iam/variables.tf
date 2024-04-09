variable "name_role" {
  description = "Name for the IAM Role"
  type        = string
}

variable "attach_to" {
  description = "the arn or role name to attach the policy created"
  type        = string
  default     = ""
}

variable "policy" {
  description = "a json with the policy"
  type        = string
  default     = ""
}

variable "name_policy" {
  description = "Name for the Policy"
  type        = string
}