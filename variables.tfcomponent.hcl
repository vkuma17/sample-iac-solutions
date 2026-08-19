variable "ibmcloud_api_key" {
  description = "APIkey that's associated with the account to provision resources to"
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "region" {
  description = "The region to provision all resources in."
  type        = string
}

variable "prefix" {
  description = "The prefix to add to all resources that this solution creates (e.g. prod, test, dev)."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC. The prefix is prepended to this name in the <prefix>-<name> format."
  type        = string
  default     = "vpc"
}
