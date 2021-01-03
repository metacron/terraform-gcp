
# ---------------------------------------------------------------------------------------------------------------------
# Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "self_link" {
  description = "A reference (self_link) to the subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork.self_link
}

output "subnetwork_name" {
  description = "Name of the subnetwork"
  value       = google_compute_subnetwork.vpc_subnetwork.name
}

output "subnetwork_cidr_blocks" {
  value = concat(
    [google_compute_subnetwork.vpc_subnetwork.ip_cidr_range],
    [for range in var.secondary_ranges : range["cidr_block"]]
  )
}

output "subnetwork_cidr_blocks_map" {
  value = { for range in var.secondary_ranges : range["name"] => range }
}
