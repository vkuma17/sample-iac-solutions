##############################################################################
# Resource Group
##############################################################################
component "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.8"
  inputs = {
    resource_group_name = "${var.prefix}-rg"
  }

  providers = {
    ibm = provider.ibm.this
  }
}

##############################################################################
# Provision VPC
##############################################################################

component "slz_vpc" {
  source  = "terraform-ibm-modules/terraform-ibm-landing-zone-vpc/ibm"
  version = "9.2.3"

  inputs = {
    resource_group_id = component.resource_group.resource_group_id
    region            = var.region
    name              = "vpc"
    prefix            = var.prefix
    resource_tags     = var.resource_tags
    subnets = {
      zone-1 = [
        {
          name           = "subnet-a"
          cidr           = "10.10.10.0/24"
          public_gateway = true
          acl_name       = "vpc-acl"
        }
      ],
      zone-2 = [
        {
          name           = "subnet-b"
          cidr           = "10.20.10.0/24"
          public_gateway = true
          acl_name       = "vpc-acl"
        }
      ],
      zone-3 = [
        {
          name           = "subnet-c"
          cidr           = "10.30.10.0/24"
          public_gateway = true
          acl_name       = "vpc-acl"
        }
      ]
    }
    security_group_rules = [{
      name       = "allow-all-inbound-sg"
      direction  = "inbound"
      remote     = "0.0.0.0/0"
      local      = "0.0.0.0/0"
      ip_version = "ipv4"
    }]
  }

  providers = {
    ibm = provider.ibm.this
  }
}
