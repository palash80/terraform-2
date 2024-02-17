resource "aws_internet_gateway" "access" {
  vpc_id = var.id_vpc

  tags = {
    Name = var.igw_name
  }
  }
