locals {
  inst_type     = "t2.micro"
  key           = "cba-web-KP"
  key_pair_path = "/home/adeola/cba-web-KP.pem"
}

# EC2 instance configuration
resource "aws_instance" "pub1a" {
  ami                         = var.ami
  instance_type               = local.inst_type
  subnet_id                   = aws_subnet.public1.id
  key_name                    = local.key
  security_groups             = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "web-server-01"
  }

}

resource "aws_instance" "pub1b" {
  ami                         = var.ami
  instance_type               = local.inst_type
  subnet_id                   = aws_subnet.public1.id
  key_name                    = local.key
  security_groups             = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "web-server-02"
  }

}



# EC2 instance configuration
resource "aws_instance" "pub2a" {
  ami                         = var.ami
  instance_type               = local.inst_type
  subnet_id                   = aws_subnet.public2.id
  key_name                    = local.key
  security_groups             = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "web-server-03"
  }
}

resource "aws_instance" "pub2b" {
  ami                         = var.ami
  instance_type               = local.inst_type
  subnet_id                   = aws_subnet.public2.id
  key_name                    = local.key
  security_groups             = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "web-server-04"
  }
}





