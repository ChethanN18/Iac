resource "aws_subnet" "public" {
    count              = "${length(local.az_names)}"
    vpc_id             = "${aws_vpc.main.id}"
    cidr_block         = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
    availability_zone  = "${local.az_names[count.index]}"
    map_public_ip_on_launch = true

    tags = {
      Name = "PublicSubnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terra-internetgateway"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

    tags = {
    Name = "publicroute-table"
  }
}

resource "aws_route_table_association" "pub-sub-asso" {
  count          = length(local.az_names)
  subnet_id      = local.pub-sub-id[count.index]
  route_table_id = aws_route_table.prt.id
}

resource "aws_instance" "nat" {
  ami           = var.nat-amis[var.region]
  instance_type = "t2.micro"
  subnet_id = local.pub-sub-id[0]
  source_dest_check = false


  tags = {
    Name = "terra-nat"
  }
}