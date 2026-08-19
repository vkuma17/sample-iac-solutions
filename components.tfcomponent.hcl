##############################################################################
# Provision VPC
##############################################################################

component "slz_vpc" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-landing-zone-vpc.git//stacks/quickstart?ref=stacks-test"

  inputs = {
    prefix   = var.prefix
    region   = var.region
    vpc_name = var.vpc_name
  }

  providers = {
    ibm    = provider.ibm.this
    time   = provider.time.this
    random = provider.random.this
  }
}
