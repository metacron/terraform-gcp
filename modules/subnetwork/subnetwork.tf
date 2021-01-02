
# ---------------------------------------------------------------------------------------------------------------------
# Subnetwork Config
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = "${var.ref_hash}-${var.name}-${var.region}"

  project = var.project
  region  = var.region
  network = var.network

  private_ip_google_access = true

  ip_cidr_range = var.cidr_block

  dynamic "secondary_ip_range" {

    for_each = var.secondary_ranges == null ? [] : { for range in var.secondary_ranges : range["name"] => range }

    content {

      range_name    = secondary_ip_range.value["name"]
      ip_cidr_range = secondary_ip_range.value["cidr_block"]

    }

  }

  dynamic "log_config" {
    for_each = var.log_config == null ? [] : list(var.log_config)

    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
    }
  }

}
