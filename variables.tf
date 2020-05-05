variable "region" {
  description = "The region to create resources."
  default     = "eu-west-2"
}


variable "zone_id" {
  description = "The CIDR blocks to create the workstations in."
  default     = ""
}

variable "namespace" {
  description = <<EOH
this is the differantiates different deployment on the same subscription, every cluster should have a different value
EOH
  default = "andrevault"
}

variable "owner" {
description = "IAM user responsible for lifecycle of cloud resources used for training"
default = "andre"
}

variable "license_file" {
  default = ""
}


# URL for Vault OSS binary
variable "vault_zip_file" {
  default = "https://releases.hashicorp.com/vault/1.4.0/vault_1.4.0_linux_amd64.zip"
}

# Instance size
variable "instance_type" {
  default = "m5.large"
}