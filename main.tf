module "gke_cluster" {
  source = "./modules/gke_cluster"

  # common config
  project_id      = "helical-lantern-436602-c8"
  name            = "springboot-app-cluster"
  location        = "asia-southeast1"
  description     = "GKE Cluster for Spring Boot App"
  release_channel = "STABLE"
  labels = {
    "created-by" = "mayuresh",
    "managed-by" = "terraform"
  }

  # networking config
  network_name          = "gke-vpc"
  subnet_name           = "subnet-1"
  pod_ip_range_name     = "pod-range"
  service_ip_range_name = "service-range"
  master_authorized_networks = {
    "mayuresh-network" = "103.197.75.137/32"
  }

  # others
  addon_config = {
    "enable_gce_pd_csi"             = true,
    "enable_gcs_fuse_csi"           = true,
    "disable_hpa"                   = false,
    "disable_http_load_balancing"   = false,
    "disable_network_policy_config" = false
  }
}
