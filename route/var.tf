variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
variable "public_subnet_ids" {
  description = "IDs of the public subnets"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}
variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}
variable "nat_id" {
  description = "ID of the Internet Gateway"
  type        = string
}