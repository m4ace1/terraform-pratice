output "api_url" {
  description = "Invoke this URL to test the API Gateway + Lambda setup"
  value       = "${aws_apigatewayv2_api.api.api_endpoint}/hello"
}
