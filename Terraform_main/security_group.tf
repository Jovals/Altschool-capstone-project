
resource "aws_security_group" "sock-shop" {
  name_prefix = "sock-shop"
  vpc_id      = module.vpc.vpc_id
  description = "Security groug for sock-shop with ingress and egress rules for VPC"
}
# module "vote_service_sg" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "sock-shop"
#   description = "Security groug for sock-shop with ingress and egress rules for VPC"
#   vpc_id      = module.vpc.vpc_id
# }
resource "aws_security_group_rule" "sock-shop_ingress" {
  description       = "allow inbound traffic from eks"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  security_group_id = aws_security_group.sock-shop.id
  type              = "ingress"
  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}

resource "aws_security_group_rule" "sock-shop_egress" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sock-shop.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# module "vote_service_sg" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "user-service"
#   description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
#   vpc_id      = "vpc-12345678"

#   ingress_cidr_blocks      = ["10.10.0.0/16"]
#   ingress_rules            = ["https-443-tcp"]
#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 8080
#       to_port     = 8090
#       protocol    = "tcp"
#       description = "User-service ports"
#       cidr_blocks = "10.10.0.0/16"
#     },
#     {
#       rule        = "postgresql-tcp"
#       cidr_blocks = "0.0.0.0/0"
#     },
#   ]
# }