output "vpc_id" {
  value = aws_vpc.lab_ecs_vpc.id
}
output "sub_pub_1" {
  value = aws_subnet.sub_pub_1.id
}
output "sub_pub_2" {
  value = aws_subnet.sub_pub_2.id
}
