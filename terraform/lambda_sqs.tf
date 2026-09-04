resource "aws_lambda_event_source_mapping" "sqs" {
  event_source_arn = aws_sqs_queue.pedidos.arn
  function_name    = aws_lambda_function.consumer.arn
  batch_size       = 1
  enabled          = true
}
