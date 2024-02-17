output "subnet-id" {
    value=aws_subnet.public_subnet[*].id
}
output "prisubnet-id" {
    value=aws_subnet.private_subnet[*].id
}