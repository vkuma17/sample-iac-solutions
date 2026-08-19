

required_providers {
  ibm = {
    source  = "ibm-cloud/ibm"
    version = ">= 1.87.3"
  }
  time = {
    source  = "hashicorp/time"
    version = ">= 0.9.1, < 1.0.0"
  }
  random = {
    source  = "hashicorp/random"
    version = ">= 3.5.1, < 4.0.0"
  }
}

provider "ibm" "this" {
  config {
    ibmcloud_api_key = var.ibmcloud_api_key # pragma: allowlist secret
    region           = var.region
  }
}

provider "time" "this" {
  config {}
}

provider "random" "this" {
  config {}
}
