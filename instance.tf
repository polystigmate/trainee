resource "aws_instance" "ubuntu-1-instance" {
    ami = "ami-0d527b8c289b4af7f"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.polygon-subnet-public-1.id

    vpc_security_group_ids = [aws_security_group.polygon-http-rdp-winrm.id]

    key_name = "thirstyserver"

     security_groups = [aws_security_group.polygon-http-rdp-winrm.id]
                user_data = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
                echo "Test Server 1" | sudo tee /var/www/html/index.html
                EOF

    tags = {
      "Name" = "ubuntu-1-instance"
    }


  
}

resource "aws_instance" "ubuntu-2-instance" {
    ami = "ami-0d527b8c289b4af7f"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.polygon-subnet-public-2.id

    vpc_security_group_ids = [aws_security_group.polygon-http-rdp-winrm.id]

    key_name = "thirstyserver"

    security_groups = [aws_security_group.polygon-http-rdp-winrm.id]
                user_data = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
                echo "Test Server 2" | sudo tee /var/www/html/index.html
                EOF

    tags = {
      "Name" = "ubuntu-2-instance"
    }
}