use_aws_account() {
  local aws_account=$1
  eval "export AWS_ACCESS_KEY_ID=\$AWS_ACCESS_KEY_ID_${aws_account}"
  eval "export AWS_SECRET_ACCESS_KEY=\$AWS_SECRET_ACCESS_KEY_${aws_account}"
}

export use_aws_account
