module "api" {
  source = "./module/api"
}

module "cognito" {
  source         = "./module/cognito"
  user_pool_name = "my-user-pool"
  client_name    = "my-user-pool-client"

  callback_urls              = ["https://example.com/callback"]
  logout_urls                = ["https://example.com/logout"]
  verification_email_message = "Welcome to M4ace. Use this OTP to verify your account {####} "
  verification_email_subject = "Thank you for registering with M4ace"
  verification_sms_message   = "You have registered for M4ace"


}

module "user_table" {
  source = "./module/dynamodb/user_table"
  table_name = "user_table"
}

module "upscale_table" {
  source = "./module/dynamodb/upscale_table"
  table_name = "upscale_table"
}

module "policy" {
  source = "./module/policy"
}
module "role" {
  source = "./module/role"
}

