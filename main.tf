locals {
  RESOURCES_PREFIX = "blood_transfusion"
AWS_REGION = data.aws_region.current.name
AWS_CCOUNT_ID = data.aws_caller_identity.current.account_id
}

module "api" {
  source = "./module/api"
  api_registration = "myapi"
  create_user_function_arn = module.lambda.create_user_function_arn
  
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
  identity_pool_id = module.cognito.identity_pool_id
  CREATE_USER_ROLE_NAME = module.role.CREATE_USER_ROLE_NAME
  region = local.AWS_REGION
  account_id = local.AWS_CCOUNT_ID
}
module "role" {
  source = "./module/role"
  RESOURCES_PREFIX = local.RESOURCES_PREFIX
}

