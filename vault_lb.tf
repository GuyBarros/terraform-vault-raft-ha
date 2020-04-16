resource "aws_alb" "vault" {
  name = "${var.namespace}-lb"

  security_groups = [aws_security_group.vault_sg.id]
  subnets         = aws_subnet.vault_subnet.*.id

  tags = {
    Name           = "${var.namespace}-lb"
    owner          = var.owner
    created-by     = var.created-by
    sleep-at-night = var.sleep-at-night
    TTL            = var.TTL
  }
}

resource "aws_alb_target_group" "vault" {
  name = "${var.namespace}-tg"

  port     = "8200"
  vpc_id   = aws_vpc.vault_vpc.id
  protocol = "HTTPS"
  health_check {
    interval          = "5"
    timeout           = "2"
    path              = "/v1/sys/health"
    port              = "8200"
    protocol          = "HTTPS"
    matcher           = "200,472,473"
    healthy_threshold = 2
  }
}

resource "aws_alb_listener" "vault" {
  depends_on = [
    aws_acm_certificate_validation.cert
  ]

  load_balancer_arn = aws_alb.vault.arn

  port     = "8200"
  protocol = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    target_group_arn = aws_alb_target_group.vault.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "vault" {
  target_group_arn = aws_alb_target_group.vault.arn
  target_id        = aws_instance.vault-server-leader.id
  port             = "8200"
}


# resource "aws_alb_target_group" "vault2" {
#   name = "${var.namespace}-tg2"

#   port     = "8201"
#   vpc_id   = aws_vpc.vault_vpc.id
#   protocol = "HTTPS"
# }

# resource "aws_alb_listener" "vault2" {

#   load_balancer_arn = aws_alb.vault.arn

#   port     = "8201"
#   protocol = "HTTPS"
#   certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
#   ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

#   default_action {
#     target_group_arn = aws_alb_target_group.vault2.arn
#     type             = "forward"
#   }
# }

# resource "aws_alb_target_group_attachment" "vault2" {
#   target_group_arn = aws_alb_target_group.vault2.arn
#   target_id        = aws_instance.vault-server-leader.id
#   port             = "8201"
# }