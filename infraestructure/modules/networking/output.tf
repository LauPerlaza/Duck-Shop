output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "sub_pub_1" {
  value = aws_subnet.sub_pub_1.id
}
output "sub_pub_2" {
  value = aws_subnet.sub_pub_2.id
}
output "sub_priv_1" {
  value = aws_subnet.sub_priv_1.id
}
output "sub_priv_2" {
  value = aws_subnet.sub_priv_2.id
}