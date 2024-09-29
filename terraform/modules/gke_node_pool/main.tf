#####################################
## Getting the network information ##
#####################################

data "google_compute_network" "network" {
  project = var.project_id
  name    = var.network_name
}

data "google_compute_subnetwork" "subnet" {
  project = var.project_id
  name    = var.subnet_name
  region  = var.location
}

##################################
## GKE node pool configuration ##
##################################

resource "google_container_node_pool" "node_pool" {
  project            = var.project_id
  name               = var.name
  cluster            = var.gke_cluster_id
  location           = var.location
  node_locations     = var.node_locations
  initial_node_count = var.initial_node_count
  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size
    disk_type = var.disk_type
    image_type = var.image_type
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

  }
  autoscaling {
    min_node_count  = var.min_node_count
    max_node_count  = var.max_node_count
    location_policy = var.location_policy
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  network_config {
    enable_private_nodes = var.enable_private_nodes
  }
}