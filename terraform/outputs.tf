output "sqs_queue_url" {
  value = aws_sqs_queue.pedidos.url
}

output "ec2_public_ip" {
  value = aws_instance.api.public_ip
}
