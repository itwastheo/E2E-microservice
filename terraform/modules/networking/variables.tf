variable "vpc_name" {}
variable "vpc_cidr" {}
variable "availability_zones" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "database_subnets" { type = list(string) }
variable "eks_node_sg_id" {
  type    = string
  default = "" 
}