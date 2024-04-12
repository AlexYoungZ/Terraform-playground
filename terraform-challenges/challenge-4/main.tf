provider "aws" {
  region = "region"
}

data "aws_iam_users" "users" {

}

data "aws_caller_identity" "current" {

}

resource "aws_iam_user" "lb" {
  name = "admin-user-${data.aws_caller_identity.current}"
  path = "/system/"
}

output "user_names" {
  value = data.aws_iam_users.users.names
}

output "total_users" {
  value = length(data.aws_iam_users.users.names)
}