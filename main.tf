#################
## GKE cluster ##
#################

module "gke_cluster" {
  source = "./modules/gke_cluster"

  # common config
  project_id      = "helical-lantern-436602-c8"
  name            = "springboot-app-cluster"
  location        = "asia-southeast1"
  description     = "GKE Cluster for Spring Boot App"
  release_channel = "STABLE"
  node_locations = [
    "asia-southeast1-a",
    "asia-southeast1-c"
  ]

  labels = {
    "created-by" = "mayuresh",
    "managed-by" = "terraform"
  }

  # networking config
  network_name          = "gke-vpc"
  subnet_name           = "subnet1"
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

  depends_on = [module.private_service_conn]
}

##########################
## GKE Service Account  ##
##########################

module "service_account" {
  source       = "./modules/service_account"
  project_id   = "helical-lantern-436602-c8"
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
  description  = "This service account is used for the GKE cluster."
}


###########################
## GKE cluster node pool ##
###########################

module "gke_node_pool" {
  source = "./modules/gke_node_pool"

  # common config
  project_id = "helical-lantern-436602-c8"
  name       = "springboot-np"
  location   = "asia-southeast1"
  node_locations = [
    "asia-southeast1-a",
    "asia-southeast1-c"
  ]
  gke_cluster_id        = module.gke_cluster.gke_cluster_id
  initial_node_count    = 1
  machine_type          = "n1-standard-1"
  disk_size             = 20
  disk_type             = "pd-standard"
  image_type            = "COS_CONTAINERD"
  service_account_email = module.service_account.service_account_email

  # network config
  network_name         = "gke-vpc"
  subnet_name          = "subnet1"
  enable_private_nodes = true

  # mgmt config
  min_node_count  = 1
  max_node_count  = 2
  location_policy = "BALANCED"
  auto_repair     = true
  auto_upgrade    = true

  depends_on = [module.private_service_conn]
}

##################################
## Private service connection ##
##################################

module "private_service_conn" {
  source = "./modules/private_service_connection"

  project_id   = "helical-lantern-436602-c8"
  network_name = "gke-vpc"
}

#########################
## Postgres cloud SQL ##
########################

module "postgres_cloud_sql" {
  source = "./modules/cloud_sql"

  # common config
  project_id           = "helical-lantern-436602-c8"
  region               = "asia-southeast1"
  name                 = "springboot-db"
  engine               = "POSTGRES_11"
  machine_type         = "db-custom-2-4096"
  disk_autoresize      = true
  disk_size            = 30
  disk_type            = "PD_HDD"
  master_user_name     = "admin"
  master_user_password = ""
  activation_policy    = "ALWAYS"
  availability_type    = "ZONAL"
  deletion_protection  = true
  custom_labels = {
    "created-by" = "mayuresh",
    "managed-by" = "terraform"
  }

  # Network config
  enable_public_internet_access = false
  network_name                  = "gke-vpc"

  # Backup Settings
  backup_enabled                          = false
  backup_region                           = "europe-west2"
  backup_start_time                       = "04:00"
  postgres_point_in_time_recovery_enabled = true

  depends_on = [module.private_service_conn]
}
