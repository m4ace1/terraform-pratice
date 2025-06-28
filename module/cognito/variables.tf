# Variable
variable "user_pool_name" {
  type        = string
  description = "Name of the Cognito User Pool"
}

variable "client_name" {
  type        = string
  description = "Name of the User Pool Client"
}

variable "callback_urls" {
  type        = list(string)
  description = "List of callback URLs"
}

variable "logout_urls" {
  type        = list(string)
  description = "List of logout URLs"
}

variable "verification_email_subject" {
  type        = string
  description = "Subject line for the email verification message"
}

variable "verification_email_message" {
  type        = string
  description = "Body of the email verification message. Use {####} as the code placeholder."
}

variable "verification_sms_message" {
  type        = string
  description = "Body of the SMS verification message. Use {####} as the code placeholder."
}
