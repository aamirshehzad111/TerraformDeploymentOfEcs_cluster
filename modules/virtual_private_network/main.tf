resource "aws_vpc" "environment_example_two" {

  cidr_block           = "${var.aws_vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.vpc_name}"
  }

}


resource "aws_internet_gateway" "IGW" {

  vpc_id = "${aws_vpc.environment_example_two.id}"
  tags = {
    Name = "IGW"
  }
}

resource "aws_subnet" "public_subnet" {
  #cidr_block = "10.0.1.0/24 "
  cidr_block              = "${cidrsubnet(aws_vpc.environment_example_two.cidr_block, 3, 1)}"
  vpc_id                  = "${aws_vpc.environment_example_two.id}"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "publicSUB" }
}

resource "aws_subnet" "public_subnet_01" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = "${aws_vpc.environment_example_two.id}"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true
  tags = {
    Name = "publicSub2"
  }
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.IGW]
  #count = 1
  vpc = true
  tags = {
    Name = "natEIP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  tags = {
    Name = "natIGW"
  }
}


resource "aws_route_table" "pub_rt" {
  vpc_id = "${aws_vpc.environment_example_two.id}"
  tags = {
    Name = "publicRT"
  }
}

resource "aws_route_table_association" "pub_association" {
  route_table_id = "${aws_route_table.pub_rt.id}"
  subnet_id      = "${aws_subnet.public_subnet.id}"

}

resource "aws_route_table_association" "pub_association_01" {
  route_table_id = "${aws_route_table.pub_rt.id}"
  subnet_id      = "${aws_subnet.public_subnet_01.id}"
}

resource "aws_route" "public_route" {
  depends_on             = [aws_internet_gateway.IGW]
  route_table_id         = "${aws_route_table.pub_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.IGW.id}"

}



resource "aws_subnet" "private_subnet" {
  cidr_block              = "${cidrsubnet(aws_vpc.environment_example_two.cidr_block, 2, 2)}"
  vpc_id                  = "${aws_vpc.environment_example_two.id}"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "privateSUB"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.environment_example_two.id}"
  tags = {
    Name = "privateRT"
  }
}

resource "aws_route_table_association" "private_association" {
  route_table_id = "${aws_route_table.private_rt.id}"
  subnet_id      = "${aws_subnet.private_subnet.id}"
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gw.id}"

}


resource "aws_security_group" "public_subnet_SG" {

  vpc_id      = "${aws_vpc.environment_example_two.id}"
  description = "Security Group to access public subnet"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    description = "http for everyone"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "ssh"
  }

  tags = {
    Name = "pubSG"
  }

}