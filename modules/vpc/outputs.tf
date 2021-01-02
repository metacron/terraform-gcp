output "private_vpc_connection" {
  # See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#private-ip-instance
  description = "VPC private services peering connection (use as depends_on value)"
  value       = google_service_networking_connection.private_vpc_connection
}

output "vpc_id" {
  description = "VPC ID"
  value       = google_compute_network.vpc.id
}

output "access_connectors" {
  # https://cloud.google.com/functions/docs/networking/connecting-vpc#create-connector
  description = "Serverles access connector configuration mapped by region"
  value       = google_vpc_access_connector.access_connectors
}
