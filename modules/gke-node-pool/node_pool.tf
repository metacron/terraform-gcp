resource "google_container_node_pool" "node_pool" {
  provider = google-beta

  name     = "${var.ref_hah}-${var.cluster_name}-${var.name}"
  location = var.location
  cluster  = var.cluster_name

  initial_node_count = var.min_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  node_config {
    image_type   = "COS"
    machine_type = var.machine_type

    labels = {
      name          = var.name
      ref_hash      = var.ref_hash
      resource_type = "kubernetes"
      cluster       = var.cluster_name
    }

    linux_node_config {
      sysctls = {
        "net.core.netdev_max_backlog" = "65536"
        "net.core.rmem_max"           = "8388608"
      }
    }

    tags = [
      "gke-${var.cluster_name}",
      "gke-pool-${var.name}",
      var.ref_hash,
      "kubernetes",
    ]

    disk_size_gb    = "50"
    disk_type       = "pd-standard"
    preemptible     = var.preemptible
    local_ssd_count = 0

    service_account = var.service_account_email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }


  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
