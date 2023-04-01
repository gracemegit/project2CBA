# Creating an RDS instance with Multi AZ

resource "aws_db_instance" "db-vm" {
  depends_on             = [aws_security_group.default]
  identifier             = "rds-instance"
  instance_class         = "db.t2.micro"
  engine                 = "mysql"
  engine_version         = "5.7"
  multi_az               = true
  publicly_accessible    = true
  storage_type           = "gp2"
  allocated_storage      = 20
  db_name                = "mydb"
  username               = "myuser"
  network_type           = "IPV4"
  password               = "mypassword"
  apply_immediately      = "true"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.my-rds-db-subnet.name
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
}

resource "aws_security_group" "default" {
  name        = "main_rds_sg"
  description = "Allow traffic from web servers"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = ["${aws_security_group.web.id}"]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "postgresql access"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #security_groups = ["${aws_security_group.web.id}"] 
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_db_subnet_group" "my-rds-db-subnet" {
  name       = "my-rds-db-subnet"
  subnet_ids = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]
}


