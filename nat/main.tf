resource "aws_eip" "lb" {
  #count= length(var.subnetid)
  domain = "vpc"
}

resource "aws_nat_gateway" "example" {
  
  #count=length(var.subnetid)
  allocation_id = aws_eip.lb.id 
  #[count.index].id
  //selecting the public subnet to create nat gateway in that subnet.
  #subnet_id =element(var.subnetid[*],count.index)
  subnet_id = var.subnetid[0]


  tags = {
    Name = var.nat_gw
  }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.n_gateway]
}