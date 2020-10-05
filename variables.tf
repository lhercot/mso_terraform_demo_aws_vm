
variable "region" {
  type = string
  default = "us-west-1"
  description = "The AWS region"
}

variable "eip_aws_id" {
  type = string
  default = "eipalloc-0b7bb1f426179e2fa"
  description = "An AWS Elastic IP AWS id"
}

variable "subnet_dn" {
  type = string
  default = "uni/tn-WoS/ctxprofile-WoS-VRF-us-west-1/cidr-[10.101.100.0/24]/subnet-[10.101.100.128/25]"
  description = "The ACI subnet object DN"
}

variable "db_ip_address" {
  type = string
  default = "10.101.10.11"
  description = "The IP address of the DB VM to point to"
}

variable "vm_name" {
  type = string
  default = "example"
  description = "The VM name"
}

variable "ssh_key_name" {
  type = string
  default = "WoS"
  description = "An AWS SSH key name for the VM user"
}