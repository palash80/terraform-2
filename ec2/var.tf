variable "len"{
    type=number
}
variable "image-id"{
    type=string
}
variable "publ_subnet"{
    type=list(string)
}
variable "priv_subnet"{
    type=list(string)
}
variable "public_keypair"{
    type=string
}
variable "sg"{
    type=list(string)
}
variable "private_sg"{
    type=list(string)
}
