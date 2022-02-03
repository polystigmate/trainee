resource "aws_vpc" "polygon-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "polygon-vpc"
  }
} 

resource "aws_subnet" "polygon-subnet-public-1" {
    vpc_id = aws_vpc.polygon-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-central-1a"

    tags = {
      "Name" = "polygon-subnet-public-1"
    }
}

resource "aws_subnet" "polygon-subnet-public-2" {
    vpc_id = aws_vpc.polygon-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-central-1b"

    tags = {
      "Name" = "polygon-subnet-public-2"
    }
}

resource "aws_internet_gateway" "polygon-igw" {
    vpc_id = aws_vpc.polygon-vpc.id

    tags = {
      "Name" = "polygon-igw"
    }
}

resource "aws_route_table" "polygon-public-crt" {
    vpc_id = aws_vpc.polygon-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.polygon-igw.id
    }
    
    tags = {
        Name = "polygon-public-crt"
    }
}

resource "aws_route_table_association" "polygon-crta-public-subnet-1"{
    subnet_id = aws_subnet.polygon-subnet-public-1.id
    route_table_id = aws_route_table.polygon-public-crt.id
}

resource "aws_route_table_association" "polygon-crta-public-subnet-2"{
    subnet_id = aws_subnet.polygon-subnet-public-2.id
    route_table_id = aws_route_table.polygon-public-crt.id
}

resource "aws_security_group" "polygon-http-rdp-winrm" {
    vpc_id = aws_vpc.polygon-vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port = 5985
        to_port = 5985
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "Name" = "lesson7-http-rdp-winrm"
    }
}