variable "ref_hash" {
  type        = string
  description = "Reference hash from source branch/tag"
}

variable "name" {
  type        = string
  description = "Unique name of the pool"
}

variable "cluster_name" {
  type        = string
  description = "The unique name of the cluster"
}

variable "location" {
  type        = string
  description = "Location code (region or zone) of the cluster"
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of nodes"
  default     = 5
}

variable "min_node_count" {
  type        = number
  description = "Minimum number of nodes"
  default     = 1
}

variable "machine_type" {
  type        = string
  description = "Node pool instance machine type"
  default     = "n1-standard-1"
}

variable "preemptible" {
  type        = bool
  description = "Are machines in this pool preemptible?"
  default     = false
}

variable "service_account_email" {
  type        = string
  description = "The service account to be used by the Node VMs"
  default     = null
}
