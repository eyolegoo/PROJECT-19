resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.lego.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-%s-%s!", var.name, aws_vpc.lego.id, "IG")
    }
  )
}