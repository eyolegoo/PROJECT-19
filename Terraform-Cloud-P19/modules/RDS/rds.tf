#Create MySQL RDS

# This section will create the subnet group for the RDS  instance using the private subnet

resource "aws_db_subnet_group" "lego-rds" {
  name       = "lego-rds"
  subnet_ids = var.private_subnet

  tags = merge(
    var.tags,
    {
      Name = "lego-rds"
    },
  )
}

# create the RDS instance with the subnets group

resource "aws_db_instance" "lego-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "legodb"
  username               = var.db-username
  password               = var.db-password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.lego-rds.name
  skip_final_snapshot    = true
  vpc_security_group_ids = var.db-sg
  multi_az               = "true"
}

