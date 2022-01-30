locals{
    vpc_name = "${terraform.workspace == "dev" ? "javahome-dev" : "javahome-prod"}"
    az_names = "${data.aws_availability_zones.azs.names}"
    pub-sub-id = aws_subnet.public.*.id
    pri-sub-id = aws_subnet.private.*.id
    len-az = length(local.az_names)
}