#-----------------------VPC/variables.tf--------

variable "region" {
}

variable "vpc_cidr" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "preferred_number_of_public_subnet" {
  type = number
}

variable "preferred_number_of_private_subnet" {
  type = number
}

variable "private_subnet" {
  type        = list(any)
  description = "List of private subnet"
}

variable "public_subnet" {
  type        = list(any)
  description = "list of public subnet"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "name" {
  type    = string
  default = "lego"

}
variable "environment" {
  default = "true"
}

# variable "aws_vpc" {
#   type =  string
# }

