#####################################
## Variable Definitions for GCP GKE ##
#####################################

variable "project_id" {
  description = "The ID of the project in which the resources will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network to use"
  type        = string
  default     = "default"
}

variable "subnet_name" {
  description = "The name of the subnetwork to use"
  type        = string
  default     = "default"
}

variable "name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gke_cluster"
}

variable "location" {
  description = "The location (region or zone) where the GKE cluster will be deployed"
  type        = string
  default     = "asia-southeast1"
}

variable "description" {
  description = "Description of the GKE cluster"
  type        = string
  default     = "GKE Cluster for Spring Boot App"
}

variable "release_channel" {
  description = "The GKE release channel to use (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "STABLE"
}

variable "labels" {
  description = "Labels for the GKE cluster"
  type        = map(string)
  default     = {}
}

variable "pod_ip_range_name" {
  description = "The secondary range name for pods"
  type        = string
  default     = "pod-ip-range"
}

variable "service_ip_range_name" {
  description = "The secondary range name for services"
  type        = string
  default     = "service-ip-range"
}

variable "enable_l4_ilb_subsetting" {
  description = "Whether to enable L4 ILB Subsetting"
  type        = bool
  default     = true
}

variable "enable_shielded_nodes" {
  description = "Whether to enable shielded nodes for the GKE cluster"
  type        = bool
  default     = false
}

variable "master_authorized_networks" {
  description = "Whitelisted networks from which you can connect to the GKe cluster."
  type        = map(string)
  default     = {}
}

variable "addon_config" {
  description = "Add-ons that can be enabled on the GKE cluster."
  type        = map(any)
  default = {
    "enable_gce_pd_csi"             = true,
    "enable_gcs_fuse_csi"           = true,
    "disable_hpa"                   = false,
    "disable_http_load_balancing"   = false,
    "disable_network_policy_config" = false
  }
}
