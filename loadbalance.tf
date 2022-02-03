resource "aws_elb" "polygon-elb" {
  name = "polygon-elb"

  subnets = [aws_subnet.polygon-subnet-public-1.id, aws_subnet.polygon-subnet-public-2.id]

  security_groups = [ aws_security_group.polygon-http-rdp-winrm.id ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances = [aws_instance.ubuntu-1-instance.id,aws_instance.ubuntu-2-instance.id]

  tags = {
    Name = "elb-polygon"
  }
}