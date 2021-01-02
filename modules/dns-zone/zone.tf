resource "google_dns_managed_zone" "zone" {
  provider   = google
  visibility = var.is_private ? "private" : "public"

  name     = replace(var.dns_zone, ".", "-")
  dns_name = "${var.dns_zone}."

  dynamic "private_visibility_config" {
    for_each = var.is_private ? ["private"] : []

    content {

      dynamic "networks" {
        for_each = var.private_network_ids

        content {
          network_url = networks.value
        }

      }

    }

  }

}
