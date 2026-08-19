
store "varset" "ibm_credentials" {
  id       = "varset-tMJtffjjdUSpRueW" # Replace it with the ID of the HCP Terraform variable set containing IBM Cloud credentials
  category = "terraform"
}

deployment "us-east" {
  inputs = {
    prefix           = "prefix1"
    region           = "us-east"
    ibmcloud_api_key = store.varset.ibm_credentials.ibmcloud_api_key # pragma: allowlist secret
  }
}