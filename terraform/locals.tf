locals {
  region = "eu-west-1"

  tags = {
    Name       = "module-2-provisioning"
    Owner      = "Cheikh gueye"
    Module     = "devops-essentials"
    GitPath    = ":module-2-provisioning"
    DeployedBy = "terraform"
  }
}
