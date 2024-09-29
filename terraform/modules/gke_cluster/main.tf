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

#########################################
## GKE cluster for the spring boot app ##
#########################################

resource "google_container_cluster" "springboot_gke" {
  name                     = var.name
  location                 = var.location
  description              = var.description
  initial_node_count       = 1
  node_locations           = var.node_locations 
  networking_mode = "VPC_NATIVE"
  release_channel {
    channel = var.release_channel
  }
  network         = data.google_compute_network.network.id
  subnetwork      = data.google_compute_subnetwork.subnet.id
  resource_labels = var.labels
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_ip_range_name
    services_secondary_range_name = var.service_ip_range_name
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_global_access_config {
      enabled = true
    }
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
  
  enable_l4_ilb_subsetting = var.enable_l4_ilb_subsetting
  enable_shielded_nodes    = var.enable_shielded_nodes
  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks
    content {
      cidr_blocks {
        cidr_block   = master_authorized_networks_config.value
        display_name = master_authorized_networks_config.key
      }
      gcp_public_cidrs_access_enabled = true
    }
  }

  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gcs_fuse_csi_driver_config {
      enabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  node_config {
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }
}