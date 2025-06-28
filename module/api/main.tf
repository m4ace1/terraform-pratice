resource "aws_api_gateway_rest_api" "Gatewayproject" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.api_registration
      version = "1.0"
    }
    paths = {
      "/get-user" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      },
       "/create-user" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }, 
       "/update-user" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "PUT"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = "example"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "Gatewayproject" {
  rest_api_id = aws_api_gateway_rest_api.Gatewayproject.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "Gatewayproject" {
  deployment_id = aws_api_gateway_deployment.Gatewayproject.id
  rest_api_id   = aws_api_gateway_rest_api.Gatewayproject.id
  stage_name    = "Gatewayproject"
}
resource "aws_api_gateway_resource" "gateway_resources" {
  rest_api_id = aws_api_gateway_rest_api.Gatewayproject.id
  parent_id   = aws_api_gateway_rest_api.Gatewayproject.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.Gatewayproject.id
  resource_id   = aws_api_gateway_resource.MyDemoResource.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id = aws_api_gateway_rest_api.Gatewayproject.id
  resource_id = aws_api_gateway_resource.MyDemoResource.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.Gatewayproject.id
  resource_id = aws_api_gateway_resource.gateway_resources.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.Gatewayproject.id
  resource_id = aws_api_gateway_resource.gateway_resources.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/xml" = <<EOF
#set($inputRoot = $input.path('$'))
<?xml version="1.0" encoding="UTF-8"?>
<message>
    $inputRoot.body
</message>
EOF
  }
}