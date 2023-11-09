######vpc#################################
output "vpc_id" {
    value = aws_vpc.main.id
}

######subnets############################
output "public_subnet1_id" {
    value = aws_subnet.public_subnet1.id
}
output "public_subnet2_id" {
    value = aws_subnet.public_subnet2.id
}
output "private_subnet1_id" {
    value = aws_subnet.private_subnet1.id
}
output "private_subnet2_id" {
    value = aws_subnet.private_subnet2.id
}
output "vpc_cidr" {
    value = aws_vpc.main.cidr_block
    
    #"10.0.0.0/16"
}