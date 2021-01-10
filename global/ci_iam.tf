resource "aws_iam_user" "ci" {
  name = "ci"
  path = "/"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.ci.name
}
