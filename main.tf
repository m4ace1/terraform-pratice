module "api" {
  source = "./module/api"
}

module "cognito" {
  source = "./module/cognito"
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