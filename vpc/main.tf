
resource "aws_vpc" "batch24" {
  cidr_block=var.cidr
    tags = {
    Name = var.name
  }
  
}
