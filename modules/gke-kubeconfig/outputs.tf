output "context" {
  description = "The name of the current Kube config context."
  value       = "gke_${local.kubeconfig_vars.suffix}"
}

output "endpoint" {
  description = "The endpoint of the Kube API server."
  value       = "${local.kubeconfig_vars.endpoint}"
}

output "kubeconfig" {
  description = "The path of the created Kubernetes client config."
  value       = "${var.kubeconfig}"
}

output "name" {
  description = "The name of the cluster."
  value       = "${var.name}"
}
