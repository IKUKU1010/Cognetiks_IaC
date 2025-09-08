resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.name}-bucket-${random_id.bucket_suffix.hex}"
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    filter {
      prefix = "" # applies to all objects
    }

    expiration {
      days = 365
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket
}
