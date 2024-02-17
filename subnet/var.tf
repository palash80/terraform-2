variable "subnet_cidr"{
    type=string
    description="cidr-block of the vpc"
    default="10.2.1.0/24"
}
variable "vpcid"{
    type=string
    description="cidr-block of the vpc"
    default="xyz"
}
variable "pub_subnet-cidr" {
  type = list(string)
 # default= ["10.15.0.0/24", "10.15.64.0/18"]
}
variable "naam" {
  type = list(string)

}

variable "len"{
    type=number
}
variable "pri_subnet-cidr"{
    type=list(string)
}
variable "prinaam" {
  type = list(string)

}