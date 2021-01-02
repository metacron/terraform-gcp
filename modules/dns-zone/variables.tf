variable "dns_zone" {
  type        = string
  description = "Root DNS zone name"
  default     = "my-zone.com"
}

variable "is_private" {
  type        = bool
  description = "Is a private zone?"
  default     = true
}

variable "private_network_ids" {
  type        = list
  description = "VPC private IDs that have access to this DNS"
  default     = []
}
