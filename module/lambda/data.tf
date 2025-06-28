# Package the Lambda function code
data "archive_file" "create_user" {
  type        = "zip"
  source_file = "${path.module}/codes/create_user"
  output_path = "${path.module}/codes/create_user.zip"
}