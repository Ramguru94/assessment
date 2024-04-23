module "base_label" {
  source = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version     = "0.25.0"
  namespace   = "ll"
  environment = var.environment
  delimiter   = "-"
  # TODO: Adding lables for more visibility
  tags = {
    "environment"  = var.environment
    "managed_by"   = "Terraform"
    "team"         = "DevOps"
    "owner"        = "raamguruvishnu94@gmail.com"
    "repo"         = "Ramguru94/assessment.git"
    "project_name" = "assessment"
  }
}
