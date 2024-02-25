/*resource "aws_vpc" "batch24" {
  cidr_block="10.0.0.0/16"
}*/
/*resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.batch24.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "Main"
  }
}*/
module "vpc2"{
  source= "./vpc"
  cidr= var.addr
name=var.nam 


}

module "subnet"{
  source= "./subnet"
  len=length(var.sdr)
  vpcid=module.vpc2.vpc-id
  pub_subnet-cidr=var.sdr
  pri_subnet-cidr=var.pdr
  prinaam = var.priname
 naam=var.subnet_name
}

module "gateway" {
  source="./igw"
  id_vpc=module.vpc2.vpc-id
  igw_name=var.gateway_name
}

module "nat" {
  source="./nat"
  subnetid=module.subnet.subnet-id
  nat_gw="ninja-nat-01"
  n_gateway=[module.gateway.gw_id]
}
module "route_tables" {
  source                   = "./route"
  vpc_id                   = module.vpc2.vpc-id
  public_subnet_ids        = module.subnet.subnet-id
  private_subnet_ids       = module.subnet.prisubnet-id
  internet_gateway_id      = module.gateway.gw_id
  nat_id=module.nat.ngw
}
module "ec2"{
  source="./ec2"
  image-id=var.am
  len=2
  public_keypair=aws_key_pair.tf-key-pair.key_name
  publ_subnet = module.subnet.subnet-id
  priv_subnet=module.subnet.prisubnet-id
  sg=[aws_security_group.allow_all.id]
  private_sg = [aws_security_group.private_subnet_sg.id]
  depends_on = [aws_security_group.allow_all]
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "palash414.pem"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "./palash414.pem"  # Provide the desired path and file name with .pem extension
}

resource "aws_security_group" "allow_all" {
  name        = "allow-all-traffic"
  description = "Allow all traffic"
  
  // VPC ID where you want to create the security group
  vpc_id = module.vpc2.vpc-id

  // Inbound rule allowing all traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  // Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.all
  }
}

resource "aws_security_group" "private_subnet_sg" {
  name        = "private-instance-traffic"
  description = "only ssh access"
  
  // VPC ID where you want to create the security group
  vpc_id = module.vpc2.vpc-id

  // Inbound rule allowing all traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sdr
  }

  // Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.all
  }
}

resource "aws_vpc_peering_connection" "peering_connection" {
  vpc_id      = "vpc-0cfe589c876fb2ff6"
  peer_vpc_id = module.vpc2.vpc-id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name = "peering_connection"
  }
}

# Associate the peering connection with a route table in VPC1
resource "aws_route" "route_to_peer" {
  route_table_id            = "rtb-082eddd97ecc7a43c"
  destination_cidr_block    = "10.8.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
}

# Associate the peering connection with a route table in VPC2
resource "aws_route" "route_to_peer_vpc2" {
  route_table_id            = module.route_tables.private_peer_route
  destination_cidr_block    = "172.31.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
}
