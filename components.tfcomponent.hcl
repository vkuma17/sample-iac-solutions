##############################################################################
# Resource Group
##############################################################################

component "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.6.1"
  inputs = {
    existing_resource_group_name = var.existing_resource_group_name
  }

  providers = {
    ibm = provider.ibm.this
  }
}

##############################################################################
# Provision VPC
##############################################################################

component "slz_vpc" {
  source  = "terraform-ibm-modules/landing-zone-vpc/ibm"
  version = "9.2.3"

  inputs = {
    resource_group_id = component.resource_group.resource_group_id
    region            = var.region
    name              = var.vpc_name
    prefix            = var.prefix
    resource_tags     = var.resource_tags
    access_tags       = var.access_tags

    # public_web_services profile: public gateways enabled in all 3 zones
    use_public_gateways = {
      zone-1 = true
      zone-2 = true
      zone-3 = true
    }

    subnets = {
      zone-1 = [
        {
          name           = "${var.prefix}-subnet-a"
          cidr           = "10.10.10.0/24"
          public_gateway = true
          acl_name       = "${var.prefix}-acl"
          no_addr_prefix = false
        }
      ]
      zone-2 = [
        {
          name           = "${var.prefix}-subnet-b"
          cidr           = "10.20.10.0/24"
          public_gateway = true
          acl_name       = "${var.prefix}-acl"
          no_addr_prefix = false
        }
      ]
      zone-3 = [
        {
          name           = "${var.prefix}-subnet-c"
          cidr           = "10.30.10.0/24"
          public_gateway = true
          acl_name       = "${var.prefix}-acl"
          no_addr_prefix = false
        }
      ]
    }

    # public_web_services profile: IBM cloud internal + VPC connectivity rules + SSH/HTTP/HTTPS
    network_acls = [
      {
        name                         = "${var.prefix}-acl"
        add_ibm_cloud_internal_rules = true
        add_vpc_connectivity_rules   = true
        prepend_ibm_rules            = true
        rules = [
          {
            name            = "allow-inbound-ssh"
            action          = "allow"
            direction       = "inbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = 22
            port_max        = 22
            source_port_min = null
            source_port_max = null
          },
          {
            name            = "allow-inbound-http"
            action          = "allow"
            direction       = "inbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = 80
            port_max        = 80
            source_port_min = null
            source_port_max = null
          },
          {
            name            = "allow-inbound-https"
            action          = "allow"
            direction       = "inbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = 443
            port_max        = 443
            source_port_min = null
            source_port_max = null
          },
          {
            name            = "allow-outbound-ssh"
            action          = "allow"
            direction       = "outbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = null
            port_max        = null
            source_port_min = 22
            source_port_max = 22
          },
          {
            name            = "allow-outbound-http"
            action          = "allow"
            direction       = "outbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = null
            port_max        = null
            source_port_min = 80
            source_port_max = 80
          },
          {
            name            = "allow-outbound-https"
            action          = "allow"
            direction       = "outbound"
            source          = "0.0.0.0/0"
            destination     = "0.0.0.0/0"
            protocol        = "tcp"
            port_min        = null
            port_max        = null
            source_port_min = 443
            source_port_max = 443
          }
        ]
      }
    ]

    # public_web_services profile: allow SSH/HTTP/HTTPS inbound on default security group
    security_group_rules = [
      {
        name      = "allow-ssh"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        protocol  = "tcp"
        port_min  = 22
        port_max  = 22
      },
      {
        name      = "allow-http"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        protocol  = "tcp"
        port_min  = 80
        port_max  = 80
      },
      {
        name      = "allow-https"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        protocol  = "tcp"
        port_min  = 443
        port_max  = 443
      }
    ]

    # public_web_services profile: keep default SG/ACL rules (not cleaned)
    clean_default_sg_acl = false
  }

  providers = {
    ibm  = provider.ibm.this
    time = provider.time.this
  }
}
