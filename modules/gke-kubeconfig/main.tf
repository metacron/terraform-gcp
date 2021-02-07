data "google_container_cluster" "cluster" {
  name     = var.name
  location = var.location
}

locals {
  auth_types = {
    cert = templatefile("${path.module}/config-auth-cert.tpl", {
      client_cert = data.google_container_cluster.cluster.master_auth.0.client_certificate
      client_key  = data.google_container_cluster.cluster.master_auth.0.client_key
    })

    gcloud = templatefile("${path.module}/config-auth-gcloud.tpl", {
      gcloud_path = var.gcloud_path
    })

    password = templatefile("${path.module}/config-auth-password.tpl", {
      password = data.google_container_cluster.cluster.master_auth.0.password
      username = data.google_container_cluster.cluster.master_auth.0.username
    })
  }

  kubeconfig = templatefile("${path.module}/config.tpl", {
    auth                   = trimspace(lookup(local.auth_types, var.auth_type))
    cluster_ca_certificate = data.google_container_cluster.cluster.master_auth.0.cluster_ca_certificate
    endpoint               = data.google_container_cluster.cluster.endpoint
    suffix                 = "${data.google_container_cluster.cluster.project}_${coalesce(var.region, var.zone)}_${data.google_container_cluster.cluster.name}"
  })
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = var.kubeconfig
}
