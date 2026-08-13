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
  description = "The prefix to add to all resources that this solution creates (e.g. prod, test, dev). Important: updating the prefix after the initial deployment may require recreating certain resources."
  type        = string
}

variable "existing_resource_group_name" {
  description = "The name of an existing resource group to provision the resources in."
  type        = string
  default     = "Default"
}

variable "vpc_name" {
  description = "Name of the VPC. The prefix is prepended to this name in the <prefix>-<name> format."
  type        = string
  default     = "vpc"
}

variable "resource_tags" {
  description = "List of tags to add to the VPC resources."
  type        = list(string)
  default     = []
}

variable "access_tags" {
  description = "List of access management tags to add to the VPC resources."
  type        = list(string)
  default     = []
}
