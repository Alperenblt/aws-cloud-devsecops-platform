terraform {
  backend "s3" {
    bucket = "alperenblt-terraform-state-2026"
    key = "dev/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    use_lockfile = true
  }
}