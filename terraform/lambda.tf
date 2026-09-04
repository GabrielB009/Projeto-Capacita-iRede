resource "aws_lambda_function" "consumer" {
  function_name = "${var.project_name}-consumer"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}
