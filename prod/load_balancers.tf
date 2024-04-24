resource "aws_alb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.alb_SG.id ]
  subnets            = [ aws_subnet.web_subnet_a.id, aws_subnet.web_subnet_b.id ]

  tags = {
    Name = "alb"
  }
}

resource "aws_alb_listener" "alb_http_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_trgt_gp.arn
  }
}

resource "aws_alb_target_group" "alb_trgt_gp" {
  name     = "alb-trgt-gp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prod_vpc.id
}

resource "aws_lb_target_group_attachment" "alb_trgt_attch_a" {
  target_group_arn = aws_alb_target_group.alb_trgt_gp.arn
  target_id        = aws_instance.web_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_trgt_attch_b" {
  target_group_arn = aws_alb_target_group.alb_trgt_gp.arn
  target_id        = aws_instance.web_b.id
  port             = 80
}