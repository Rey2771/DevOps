terraform {
  backend "s3" {
    bucket       = "tf-aws-webapp-301e3449"
    key          = "webapp/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}