########################
## Variables for GKE  ##
########################

# Project ID
variable "project_id" {
  description = "The ID of the project where resources will be created."
  type        = string
}

# Network name
variable "network_name" {
  description = "The name of the VPC network to use."
  type        = string
}

# Subnet name
variable "subnet_name" {
  description = "The name of the subnetwork to use."
  type        = string
}

# Node locations
variable "node_locations" {
  description = "Zones where GKE nodes would be deployed."
  type        = list(string)
  default     = []
} 

# GKE Cluster ID
variable "gke_cluster_id" {
  description = "The ID of the GKE cluster where the node pool will be created."
  type        = string
}

# Node pool name
variable "name" {
  description = "The name of the node pool."
  type        = string
}

# Location (region/zone)
variable "location" {
  description = "The region or zone where the resources will be created."
  type        = string
}

# Initial node count
variable "initial_node_count" {
  description = "The initial number of nodes for the node pool."
  type        = number
  default     = 1
}

# Machine type
variable "machine_type" {
  description = "The type of machine to use for the node pool."
  type        = string
  default     = "e2-medium"
}

# Disk size
variable "disk_size" {
  description = "The disk size in GB for each node in the node pool."
  type        = number
  default     = 20
}

# Disk type
variable "disk_type" {
  description = "The type of disk to attach to each node (e.g., pd-standard, pd-ssd)."
  type        = string
  default     = "pd-standard"
}

# Image type
variable "image_type" {
  description = "The image type to use for the node pool [COS_CONTAINERD, COS, UBUNTU_CONTAINERD, UBUNTU]."
  type        = string
  default     = "COS_CONTAINERD"
}

# Service account email
variable "service_account_email" {
  description = "The email of the service account to attach to the node pool."
  type        = string
}

# Minimum node count for autoscaling
variable "min_node_count" {
  description = "The minimum number of nodes for autoscaling."
  type        = number
  default     = 1
}

# Maximum node count for autoscaling
variable "max_node_count" {
  description = "The maximum number of nodes for autoscaling."
  type        = number
  default     = 3
}

# Location policy
variable "location_policy" {
  description = "The location policy for the node pool (either BALANCED or ANY)."
  type        = string
  default     = "BALANCED"
}

# Auto repair
variable "auto_repair" {
  description = "Whether to enable auto-repair for the node pool."
  type        = bool
  default     = true
}

# Auto upgrade
variable "auto_upgrade" {
  description = "Whether to enable auto-upgrade for the node pool."
  type        = bool
  default     = true
}

# Enable private nodes
variable "enable_private_nodes" {
  description = "Whether to enable private nodes in the GKE cluster."
  type        = bool
  default     = false
}
