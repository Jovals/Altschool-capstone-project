variable "kubernetes_version" {
  default     = 1.30
  description = "kubernetes version"
}

variable "vpc_cidr" {
  description = "default CIDR range of the VPC"
  type = string
}
variable "aws_region" {
  description = "aws region"
  type = string
}
variable "azs" {
  description = "availability zones for sock shop"
  type = list(string )
  
}
variable "cluster_name" {
  description = "name of the cluster"
  type = string
}

variable "ami_type" {
  description = "ami type"
  type = string
}
variable "private_subnets" {
  description = "private subnets"
  type = list(string)
  
}
variable "public_subnets" {
  description = "public subnets"
  type = list(string) 
  
}
# variable "security_group_id_cidr" {
#   description = "security group id"
#   type = string
  
# }
