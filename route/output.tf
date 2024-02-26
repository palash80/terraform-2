output "private_peer_route" {
value = aws_route_table.private.id
}

output "public_peer_route" {
value = aws_route_table.public.id
}
