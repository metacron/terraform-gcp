# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "ref_hash" {
  type        = string
  description = "Reference hash from source branch/tag"
}

variable "project" {
  description = "The project ID for the network"
  type        = string
}

variable "region" {
  description = "The region for subnetworks in the network"
  type        = string
}

variable "name" {
  description = "A name used in resource names to ensure uniqueness across a project"
  type        = string
}

variable "router_name" {
  description = "The router name used to deploy nat"
  type        = string
}

variable "network" {
  description = "Network this subnet belongs to"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "subnetworks" {
  description = "Subnetwork 'self_link' list to allow use nat."
  default     = []
  type        = list(any)
}
