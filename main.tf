data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jenkinshandson"
    key    = "terraform/vpc"
    region = "us-east-1"
  }
}
module "key" {
  source = "./modules/keypair"
}

module "app" {
  source                 = "./modules/application"
  subnet_list            = [data.terraform_remote_state.vpc.outputs.subnet-1-id, data.terraform_remote_state.vpc.outputs.subnet-2-id]
  elb-securitygroup      = [data.terraform_remote_state.vpc.outputs.elb-security-grp-id]
  instance-securitygroup = [data.terraform_remote_state.vpc.outputs.instance-security-grp-id]
  key_name               = module.key.mykeypair
}
provider "aws" {
  region = var.AWS_REGION
}