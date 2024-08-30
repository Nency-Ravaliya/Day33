resource "aws_db_instance" "nency_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.nency_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.nency_db_subnet_group.name
  skip_final_snapshot    = true

  tags = {
    Name = "nency-db-instance"
  }
}

resource "aws_db_subnet_group" "nency_db_subnet_group" {
  name       = "nency-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "nency-db-subnet-group"
  }
}

resource "aws_security_group" "nency_db_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "nency-db-sg"
  }
}

