provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "new" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "new-vpc"
  }
}
resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.new.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "pri_subnet" {
  vpc_id     = aws_vpc.new.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
}    

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.new.id
  
  tags = {
    Name = "new-igw"
  }

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.new.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "pub-route-table"
    }
}

resource "aws_route_table_association" "pub_subnet_association" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_eip" "nat_eip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_subnet.id

  tags = {
    Name = "nat-gw"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.new.id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gw.id
    cidr_block     = "0.0.0.0/0"
    }
    }

resource "aws_route_table_association" "pri_subnet_association" {
  subnet_id      = aws_subnet.pri_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "sg" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.new.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg2" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.new.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
 resource "aws_security_group" "sg3" {
  name        = "allow-https"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.new.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = [aws_security_group.sg2.id]
  }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }   
 }

 resource "aws_instance" "web_server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.pub_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id, aws_security_group.sg2.id, aws_security_group.sg3.id]
  key_name = "flask"
  tags = {
    Name = "web-server"
    }
 }
resource "aws_instance" "backend_server" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.pri_subnet.id
  vpc_security_group_ids = [aws_security_group.sg3.id]  
    key_name = "flask"
  tags = {
    Name = "app-server"
    }
  }
