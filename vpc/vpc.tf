#vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  
  # tags = merge (var.tags,{
  #   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc"})
tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc-${var.tags["creationTime"]}"
})
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  # tags = merge (var.tags,{
  #   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet1"})
 tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet1-${var.tags["creationTime"]}"
})
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
 
  # tags = merge (var.tags,{
  #   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}public_subnet2"})
tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet2-${var.tags["creationTime"]}"
})

}
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = var.availability_zones[0]

  # tags = merge (var.tags,{
  #   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet1"})
tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet1-${var.tags["creationTime"]}"
})

}
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet2_cidr_block
 availability_zone = var.availability_zones[1]

  #  tags = merge (var.tags,{
  #   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet2"})
tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet2-${var.tags["creationTime"]}"
})
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-igw-${var.tags["creationTime"]}"
})
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-pubrtb-${var.tags["creationTime"]}"
})
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

##################### commented to aboid charges #########################################
# resource "aws_eip" "eip" {
#   domain   = "vpc"
#     tags = merge(var.tags, {
#   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-peip-${var.tags["creationTime"]}"
# })
# }

# resource "aws_nat_gateway" "nat_gw" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet.public_subnet1.id

#   tags = merge(var.tags, {
#   Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-nat-gw-${var.tags["creationTime"]}"
# })
#   depends_on = [aws_eip.eip, aws_subnet.public_subnet1]
# }

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    #Un comment and reverse to nad 
    #gateway_id = aws_nat_gateway.nat_gw.id
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-prvrtb-${var.tags["creationTime"]}"
})
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}