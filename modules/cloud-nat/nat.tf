resource "google_compute_router" "vpc_router" {
  name = "${var.ref_hash}-${var.router_name}-router-${var.region}"

  project = var.project
  region  = var.region
  network = var.network
}


resource "google_compute_router_nat" "vpc_nat" {
  name = "${var.ref_hash}-${var.name}-nat-${var.region}"

  project = var.project
  region  = var.region
  router  = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"

  # "Manually" define the subnetworks for which the NAT is used, so that we can exclude the public subnetwork
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {

    for_each = var.subnetworks

    content {
      name                    = subnetwork.value["self_link"]
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}
