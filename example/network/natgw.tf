resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = "${local.name_prefix}-natgw"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = {
    Name = local.name_prefix
  }
}
