variable "ref_hash" {
  type        = string
  description = "Reference hash from source branch/tag"
}

variable "name" {
  type        = string
  description = "Unique network name, suggestion: use a slug like 'my_network'"
}

variable "service_networking_regions" {
  type        = list(string)
  description = "Regions to enalbe Google private Service Networking"
  default     = []
}

variable "access_connectors" {
  type        = map
  description = "Access connectors configuration using region as key. CIDR is an unreserved internal IP network, and a '/28' of unallocated space is required. The value supplied is the network (10.8.0.0), not CIDR notation (10.8.0.0/28). This IP range must not overlap with any existing IP address reservations in your VPC network. For example, 10.8.0.0 works in most new projects."
  default = {
    "us-central1" = {

      cidr           = "10.8.0.0/28",
      min_throughput = 200,
      max_throughput = 300,

    }
  }
}
