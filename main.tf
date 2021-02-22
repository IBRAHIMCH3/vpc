resource "aws_vpc" "Ent-NonPrd-AP" {
  cidr_block       = "10.30.64.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Ent-NonPrd-AP"
  }
}
resource "aws_subnet" "Ent-NonPrd-AP-Pub-AZ1" {
  availability_zone       = "ap-south-1a"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.64.0/24"



 tags = {
    Name = "Ent-NonPrd-AP-Pub-AZ1"
  }

}
resource "aws_subnet" "Ent-NonPrd-AP-Pub-AZ2" {
  availability_zone       = "ap-south-1b"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.65.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-Pub-AZ2"
  }

}
resource "aws_subnet" "Ent-NonPrd-AP-Pub-AZ3" {
  availability_zone       = "ap-south-1c"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.66.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-Pub-AZ3"
  }

}

resource "aws_subnet" "Ent-NonPrd-AP-Web_App-AZ1" {
  availability_zone       = "ap-south-1a"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.67.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-Web_App-AZ1"
  }

}
resource "aws_subnet" "Ent-NonPrd-AP-Web_App-AZ2" {
  availability_zone       = "ap-south-1b"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.68.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-Web_App-AZ2"
  }

}

resource "aws_subnet" "Ent-NonPrd-AP-Web_App-AZ3" {
  availability_zone       = "ap-south-1c"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.69.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-Web_App-AZ3"
  }

}
resource "aws_subnet" "Ent-NonPrd-AP-DB-AZ1" {
  availability_zone       = "ap-south-1a"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.70.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-DB-AZ1"
  }

}
resource "aws_subnet" "Ent-NonPrd-AP-DB-AZ2" {
  availability_zone       = "ap-south-1b"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.71.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-DB-AZ2"
  }

}

resource "aws_subnet" "Ent-NonPrd-AP-DB-AZ3" {
  availability_zone       = "ap-south-1c"
  vpc_id     = "${aws_vpc.Ent-NonPrd-AP.id}"
  cidr_block = "10.30.72.0/24"

  tags = {
    Name = "Ent-NonPrd-AP-DB-AZ3"
  }

}
resource "aws_internet_gateway" "igw" {
   vpc_id = "${aws_vpc.Ent-NonPrd-AP.id}"

  tags = {
    Name = "internetgw"
  }

}
resource "aws_route_table" "Ent-NonPrd-AP-Pub-AZ-RT" {
  vpc_id = "${aws_vpc.Ent-NonPrd-AP.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "Ent-NonPrd-AP-Pub-AZ-RT"
  }

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Pub-AZ-Ass-1" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Pub-AZ1.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Pub-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Pub-AZ-Ass-2" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Pub-AZ2.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Pub-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Pub-AZ-Ass-3" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Pub-AZ3.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Pub-AZ-RT.id}"

}

resource "aws_eip" "eip" {
  vpc = false
}
resource "aws_nat_gateway" "nat" {
   allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.Ent-NonPrd-AP-Pub-AZ1.id}"
}

resource "aws_route_table" "Ent-NonPrd-AP-Web_App-AZ-RT" {
  vpc_id = "${aws_vpc.Ent-NonPrd-AP.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = {
    Name = "Ent-NonPrd-AP-Web_App-AZ-RT"
  }

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Web_App-AZ-Ass-1" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-DB-AZ1.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Web_App-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Web_App-AZ-Ass-2" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-DB-AZ2.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Web_App-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-Web_App-AZ-Ass-3" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-DB-AZ3.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-Web_App-AZ-RT.id}"

}
resource "aws_route_table" "Ent-NonPrd-AP-DB-AZ-RT" {
  vpc_id = "${aws_vpc.Ent-NonPrd-AP.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags = {
    Name = "Ent-NonPrd-AP-DB-AZ-RT"
  }

}
resource "aws_route_table_association" "Ent-NonPrd-AP-DB-AZ-ASS-1" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Web_App-AZ1.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-DB-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-DB-AZ-ASS-2" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Web_App-AZ2.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-DB-AZ-RT.id}"

}
resource "aws_route_table_association" "Ent-NonPrd-AP-DB-AZ-ASS-3" {
  subnet_id      = "${aws_subnet.Ent-NonPrd-AP-Web_App-AZ3.id}"
  route_table_id = "${aws_route_table.Ent-NonPrd-AP-DB-AZ-RT.id}"

}
resource "aws_security_group" "Ent-NonPrd-AP-Pub-SG" {
  name        = "Ent-NonPrd-AP-Pub-SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.Ent-NonPrd-AP.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"

  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 443 
    to_port         = 443
    protocol        = "tcp"

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "Ent-NonPrd-AP-Pub-SG"
  }
}

resource "aws_security_group" "Ent-NonPrd-AP-Web_App-SG" {
  name        = "Ent-NonPrd-AP-Web_App-SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.Ent-NonPrd-AP.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"

  }

  ingress {
    from_port       = 443 
    to_port         = 443
    protocol        = "tcp"

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "Ent-NonPrd-AP-Web_App-SG"
  }
}

resource "aws_security_group" "Ent-NonPrd-AP-DB-SG" {
  name        = "Ent-NonPrd-AP-DB-SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.Ent-NonPrd-AP.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"

  }

  ingress {
    from_port       = 443 
    to_port         = 443
    protocol        = "tcp"

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "Ent-NonPrd-AP-DB-SG"
  }
}
resource "aws_network_acl" "Ent-NonPrd-Pub-AZ" {
  vpc_id = aws_vpc.Ent-NonPrd-AP.id
  subnet_ids = [ aws_subnet.Ent-NonPrd-AP-Pub-AZ1.id,aws_subnet.Ent-NonPrd-AP-Pub-AZ2.id,aws_subnet.Ent-NonPrd-AP-Pub-AZ3.id ]



# allow ingress port 443
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # allow ingress port 80
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # allow ingress ephemeral ports
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

 # allow ingress  ports 3389
  ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  # allow egress port 443
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # allow egress port 80
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

# allow egress port 3389
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

tags = {
    Name = "Ent-NonPrd-AP-Pub-AZ-ACL-1"
}
} # end resource

resource "aws_network_acl" "Ent-NonPrd-AP-Web_App-AZ" {
   vpc_id = aws_vpc.Ent-NonPrd-AP.id
  subnet_ids = [ aws_subnet.Ent-NonPrd-AP-Web_App-AZ1.id,aws_subnet.Ent-NonPrd-AP-Web_App-AZ2.id,aws_subnet.Ent-NonPrd-AP-Web_App-AZ3.id ]


# allow ingress port 3389
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  # allow ingress port 80
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # allow ingress ephemeral ports
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
 
 ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # allow egress port 3389
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }
 

  # allow egress port 80
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
  # allow egress port 443
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }


  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
tags = {
    Name = "Ent-NonPrd-AP-Web_App-AZ-ACL-2"
}
} # end resource


resource "aws_network_acl" "Ent-NonPrd-AP-DB-AZ" {
  vpc_id = aws_vpc.Ent-NonPrd-AP.id
  subnet_ids = [ aws_subnet.Ent-NonPrd-AP-DB-AZ1.id,aws_subnet.Ent-NonPrd-AP-DB-AZ2.id,aws_subnet.Ent-NonPrd-AP-DB-AZ3.id ]


# allow ingress port 
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.30.70.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  # allow ingress port 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.30.71.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  # allow ingress ephemeral ports
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.30.72.0/24"
    from_port  = 1024
    to_port    = 65535
  }


  # allow egress port 
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.30.70.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.30.71.0/24"
    from_port  = 1024
    to_port    = 65535
  }
  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "10.30.72.0/24"
    from_port  = 1024
    to_port    = 65535
  }

tags = 	{
    Name = "Ent-NonPrd-AP-DB-AZ-ACl-3"
}
}

