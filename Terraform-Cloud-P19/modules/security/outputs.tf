#----------------Security/outputs.tf---------------------
output "ext-alb-sg" {
  value = aws_security_group.Lego["ext-alb-sg"].id
}

output "int-alb-sg" {
  value = aws_security_group.Lego["int-alb-sg"].id
}

output "bastion-sg" {
  value = aws_security_group.Lego["bastion-sg"].id
}

output "nginx-sg" {
  value = aws_security_group.Lego["nginx-sg"].id
}

output "webserver-sg" {
  value = aws_security_group.Lego["webserver-sg"].id
}

output "datalayer-sg" {
  value = aws_security_group.Lego["datalayer-sg"].id
}
