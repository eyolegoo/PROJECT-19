#------------VPC/outputs.tf-----------------
output "public_subnet_1" {
  value       = aws_subnet.public[0].id
  description = "The first public subnet in the subnets"
}

output "public_subnet_2" {
  value       = aws_subnet.public[1].id
  description = "The second public subnet"
}

output "private_subnet_1" {
  value       = aws_subnet.private[0].id
  description = "The first private subnet"
}

output "private_subnet_2" {
  value       = aws_subnet.private[1].id
  description = "The second private subnet"
}

output "private_subnet_3" {
  value       = aws_subnet.private[2].id
  description = "The third private subnet"
}

output "private_subnet_4" {
  value       = aws_subnet.private[3].id
  description = "The fourth private subnet"
}

output "vpc_id" {
  value = aws_vpc.lego.id
}

output "instance_profile" {
  value = aws_iam_instance_profile.ip.id
}

