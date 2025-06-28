module "api" {
  source = "./module/api"
}

module "cognito" {
  source = "./module/cognito"
}

module "dynamob" {
  source = "./module/dynamodb"
}
module "policy" {
  source = "./module/policy"
}
module "role" {
  source = "./module/role"
}