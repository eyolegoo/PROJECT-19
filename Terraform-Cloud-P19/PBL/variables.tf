variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "preferred_number_of_public_subnet" {
  type        = number
  description = "number of public subnet"
  default     = 2
}

variable "preferred_number_of_private_subnet" {
  type        = number
  description = "number of private subnet"
  default     = 4
}

variable "name" {
  type    = string
  default = "lego"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "ami" {
  type        = string
  description = "AMI ID for the launch template"
}

variable "ami-bastion" {
  type        = string
  description = "AMI ID for the launch template"
}

variable "ami-nginx" {
  type        = string
  description = "AMI ID for the launch template"
}

variable "ami-web" {
  type        = string
  description = "AMI ID for the launch template"
}

variable "ami-sonar" {
  type        = string
  description = "AMI ID for the launch template"
}
variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "account_no" {
  type        = number
  description = "the account number"
}

variable "db-username" {
  type        = string
  description = "RDS admin username"
}

variable "db-password" {
  type        = string
  description = "RDS master password"
}

