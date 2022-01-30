resource "aws_subnet" "private" {
    count              =  length(slice(local.az_names, 0, 2))
    vpc_id             =  aws_vpc.main.id
    cidr_block         =  cidrsubnet(var.vpc_cidr, 8, count.index + local.len-az)
    availability_zone  =  local.az_names[count.index]

    tags = {
      Name = "PrivateSubnet-${count.index + 1}"
    }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id =  aws_instance.nat.id
  }

    tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "pri-sub-asso" {
  count          = length(slice(local.az_names, 0, 2))
  subnet_id      = local.pri-sub-id[count.index]
  route_table_id = aws_route_table.private-rt.id
}