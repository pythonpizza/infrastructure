data "cloudflare_ip_ranges" "cloudflare" {}

resource "aws_s3_bucket" "website" {
  bucket = local.fulldomain

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.cloudfare_access.json
}

data "aws_iam_policy_document" "cloudfare_access" {
  statement {
    sid    = "IPAllow"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
    ]

    condition {
      test     = "NotIpAddress"
      variable = "aws:SourceIp"
      values   = data.cloudflare_ip_ranges.cloudflare.cidr_blocks
    }
  }
}
