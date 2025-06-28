resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
    {
      Sid    = "Statement1",
      Effect = "Allow",
      Action = [
        "cognito-identity:GetId",
        "cognito-identity:UnlinkIdentity",
        "cognito-identity:DescribeIdentity",
        "cognito-identity:DeleteIdentities",
        "cognito-identity:CreateIdentityPool"
      ],
      Resource = "arn:aws:cognito-identity:${var.region}:${var.account_id}:identitypool/${var.identity_pool_id}"
    },
    {
      "Sid": "Statement2",
      "Effect": "Allow",
      "Action": [
        "dynamodb:CreateTable",
        "dynamodb:PutItem",
        "dynamodb:GetRecords",
        "dynamodb:GetItem",
        "dynamodb:UpdateItem"
      ],
      "Resource": "arn:aws:dynamodb:*"
    },
    {
      "Sid": "Statement3",
      "Effect": "Allow",
      "Action": [
        "execute-api:Invoke"
      ],
      "Resource": "arn:aws:execute-api:*"
    }
  ]

}
  )
}

#policy attachment to CREATE_USER_ROLE
resource "aws_iam_role_policy_attachment" "create_user_attachment" {
  policy_arn = aws_iam_policy.policy.arn
  role = var.CREATE_USER_ROLE_NAME
}