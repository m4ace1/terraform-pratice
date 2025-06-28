resource "aws_cognito_user_pool" "user_pool" {
  name = "my-user-pool"

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = var.verification_email_subject
    email_message        = var.verification_email_message
    sms_message          = var.verification_sms_message
  }

  schema {
    name                = "first_name"
    attribute_data_type = "String"
    mutable             = false
    required            = true
    string_attribute_constraints {
      min_length = 0
      max_length = 100
    }
  }

  schema {
    name                = "last_name"
    attribute_data_type = "String"
    mutable             = false
    required            = true
    string_attribute_constraints {
      min_length = 0
      max_length = 100
    }
  }
  tags = {
    Environment = "dev"
    Name        = "MyUserPool"
  }
}
resource "aws_cognito_user_pool_domain" "main" {
  domain       = "example-domain"
  user_pool_id = aws_cognito_user_pool.example.id
}

resource "aws_cognito_user_pool" "pool" {
  name = "pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = aws_cognito_user_pool.pool.id
}





# Cognito U
