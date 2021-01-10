resource "aws_iam_user" "ci" {
  name = "ci"
  path = "/"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.ci.name
}

resource "aws_iam_user_policy" "s3_access" {
  name   = "s3access"
  user   = aws_iam_user.ci.name
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "S3CIAccess"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::*.python.pizza/*"
    ]
  }
}
