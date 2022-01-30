resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "${local.vpc_name}"
    Environment = "${terraform.workspace}"
  }
}

# output "vpc_cidr" {
#   value = "${aws_vpc.main.cidr_block}"
# }
