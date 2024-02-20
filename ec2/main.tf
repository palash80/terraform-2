 resource "aws_instance" "aws" {
    ami           = var.image-id
    count= var.len
    instance_type = "t2.micro"
    key_name = var.public_keypair
    vpc_security_group_ids= var.sg
    subnet_id=var.publ_subnet[count.index]
    associate_public_ip_address = true
    tags = {
    Name = "bastion${count.index+1}"
  }
  }
   resource "aws_instance" "aws1" {
    ami           = var.image-id
    count= var.len
    instance_type = "t2.micro"
    vpc_security_group_ids= var.private_sg
    key_name = var.public_keypair
    subnet_id=var.priv_subnet[count.index]
    associate_public_ip_address = false
    tags = {
    Name = "posgresql${count.index+1}"
    group = "psqlnodes"

  }
  }
