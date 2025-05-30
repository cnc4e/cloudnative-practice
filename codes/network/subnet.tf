resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  availability_zone       = "${local.region}${each.key}"
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name                     = "${local.name_prefix}-public-${each.key}",
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.this.id
  availability_zone       = "${local.region}${each.key}"
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name                              = "${local.name_prefix}-private-${each.key}",
    "kubernetes.io/role/internal-elb" = "1"
  }
}
