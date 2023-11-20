resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-subnet-group-${var.tags["creationTime"]}"

  subnet_ids = [var.private_subnet1, var.private_subnet2]

  tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-subnet-group-${var.tags["creationTime"]}"
})
}

########### SG #############################
resource "aws_security_group" "rds_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-rds-sg-${var.tags["creationTime"]}"
  description = "allow db traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
  Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-rds-sg-${var.tags["creationTime"]}"
})
}

################### RDS instance ###################
resource "aws_db_instance" "rds" {
  allocated_storage    = 8
  db_name              = "jjtch"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}