variable "auth_type" {
  type        = string
  default     = "gcloud"
  description = "The type of cluster auth to use. Must be one of (cert | gcloud | password)."
}

variable "gcloud_path" {
  type        = string
  default     = "gcloud"
  description = "The path of the gcloud executable."
}

variable "kubeconfig" {
  type        = string
  description = "The path of the Kubernetes client config file to create."
}

variable "name" {
  type        = string
  description = "The name of the cluster."
}

variable "location" {
  type        = string
  default     = ""
  description = "The location this cluster has been created in."
}
