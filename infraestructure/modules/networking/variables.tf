variable "region" {
  type        = string
  description = "Region"
}

variable "env" {
  type = string
}

variable "ip" {
  type        = string
  description = "ip"
}

variable "cidr_block_vpc" {
  description = "Bloque CIDR de la VPC"
  type        = string
}
variable "subnet_public" {
  type = list(string)
}


