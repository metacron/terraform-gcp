locals {

  service_networking_regions = { for region in var.service_networking_regions : region => region }

}

############################
# VPC
############################

resource "google_compute_network" "vpc" {
  provider = google

  name         = "${var.ref_hash}-${var.name}"
  mtu          = 1500
  routing_mode = "REGIONAL"

  auto_create_subnetworks         = false
  delete_default_routes_on_create = true

}

############################
# Routing
############################

# resource "google_compute_route" "vpc_route_default_internet_gw" {
#   provider         = google
#   name             = "${var.ref_hash}-${var.name}-default-internet-gateway"
#   dest_range       = "0.0.0.0/0"
#   network          = google_compute_network.vpc.name
#   next_hop_gateway = "default-internet-gateway"
#   priority         = 1000
# }

############################
# VPC private services
############################

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  for_each = local.service_networking_regions

  name          = "${var.ref_hash}-${var.name}-${each.value}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id

  labels = {
    ref_hash      = var.ref_hash,
    resource_type = "ip",
    name          = var.name,
  }

}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  for_each = local.service_networking_regions

  network = google_compute_network.vpc.id
  service = "servicenetworking.googleapis.com"

  reserved_peering_ranges = [
    google_compute_global_address.private_ip_address[each.key].name,
  ]
}

############################
# VPC access connector
############################

resource "google_vpc_access_connector" "access_connectors" {
  provider = google

  for_each = var.access_connectors

  name          = format("%s-%s", "conn", substr(sha256("${var.ref_hash}-${var.name}-${each.key}"), 0, 20))
  region        = each.key
  ip_cidr_range = each.value["cidr"]
  network       = google_compute_network.vpc.name

  min_throughput = lookup(each.value, "min_throughput", 200)
  max_throughput = lookup(each.value, "max_throughput", 300)

}
