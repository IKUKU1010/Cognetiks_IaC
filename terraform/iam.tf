# -----------------------------
# Terraform full-access policy
# -----------------------------
resource "aws_iam_policy" "terraform_full_access" {
  name        = "TerraformFullAccess"
  description = "Full permissions for Terraform to manage VPC, EC2, ELB, RDS"
  policy      = file("${path.module}/terraform_full_access.json")  # JSON file
}

# -----------------------------
# Attach policy to your IAM user
# -----------------------------
resource "aws_iam_user_policy_attachment" "terraform_attach" {
  user       = "Obed-Edom"   # <- replace with your IAM username
  policy_arn = aws_iam_policy.terraform_full_access.arn
}
