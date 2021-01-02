# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "network" {
  description = "A reference (self_link) to the VPC network to apply firewall rules to"
  type        = string
}

variable "allowed_public_restricted_subnetworks" {
  description = "The public networks that is allowed access to the public_restricted subnetwork of the network"
  default     = []
  type        = list(string)
}

variable "allowed_all_inbound_cidr_ranges" {
  description = "CIDR blocks to allow all inbound traffic"
  type        = list(any)
  default     = []
}

variable "project" {
  description = "The project to create the firewall rules in. Must match the network project."
  type        = string
}

variable "ref_hash" {
  type        = string
  description = "Reference hash from source branch/tag"
}

variable "name" {
  description = "A name used in resource names to ensure uniqueness across a project."
  type        = string
}
