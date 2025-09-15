resource "aws_s3_bucket" "example" {
  for_each = var.mybucket
  bucket   = each.value.bucket

  tags = each.value.tags
}
# aws_s3_bucket_acl
resource "aws_s3_bucket_public_access_block" "example" {
  for_each = aws_s3_bucket.example

  bucket = each.value.id

  block_public_acls       = try(each.value.block_public_acls, false)
  block_public_policy     = try(each.value.block_public_policy, false)
  ignore_public_acls      = try(each.value.ignore_public_acls, false)
  restrict_public_buckets = try(each.value.restrict_public_buckets, false)
}

# aws_s3_bucket_versioning
resource "aws_s3_bucket_versioning" "versioning_example" {
  for_each = aws_s3_bucket.example

  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}

# aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = aws_s3_bucket.example

  bucket = each.value.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "s3:GetObject"
        Principal = "*"
        Resource  = "${each.value.arn}/*"
      }
    ]
  })

}

# aws_s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  for_each = aws_s3_bucket.example

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# aws_s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "example" {
  for_each = aws_s3_bucket.example

  bucket = each.value.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  # With routing_rule configured
  /*
  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
*/
}
