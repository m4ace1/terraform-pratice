# Lambda function
resource "aws_lambda_function" "create_user_lambda" {
  filename         = "${path.module}/codes/zip/create_user.zip"
  function_name    = "create_user"
  role             = var.CREATE_USER_ROLE_ARN
  handler          = "index.handler"
  source_code_hash = data.archive_file.example.output_base64sha256

  runtime = "python3.13"


  tags = {
    Environment = "production"
    Application = "example"
  }
}
