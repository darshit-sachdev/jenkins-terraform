resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = var.subnet_list
  security_groups = var.elb-securitygroup
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

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}
resource "aws_launch_template" "example-launchtemplate" {
  name_prefix     = "example-launchtemplate"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = var.key_name
  vpc_security_group_ids = var.instance-securitygroup
  user_data       = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = var.subnet_list
  launch_template {
    id      = aws_launch_template.example-launchtemplate.id
    version = "$Latest"
  } 
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}


