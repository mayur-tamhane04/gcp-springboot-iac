variable "project_id" {
  description = "The project ID to host the database."
  type        = string
}

variable "charset" {
  description = "The charset value."
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "The collation value."
  type        = string
  default     = "en_US.UTF8"
}

variable "network_name" {
  description = "VPC name from which Cloud SQL would be connected."
  type        = string
  default     = ""
}

variable "region" {
  description = "The region to host the database."
  type        = string
}

variable "name" {
  description = "The name of the database instance."
  type        = string
}

variable "engine" {
  description = "The engine version of the database."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the instances. See this page for supported tiers and pricing."
  type        = string
}

variable "master_user_name" {
  description = "The username part for the default user credentials."
  type        = string
  default     = null
}

variable "master_user_password" {
  description = "The password part for the default user credentials."
  type        = string
  default     = null
}

variable "activation_policy" {
  description = "This specifies when the instance should be active. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)."
  type        = string
  default     = "ZONAL"
}

variable "authorized_networks" {
  description = "A list of authorized CIDR-formatted IP address ranges that can connect to this DB. Only applies to public IP instances."
  type        = list(map(string))
  default     = []
}

variable "backup_enabled" {
  description = "Set to false if you want to disable backup."
  type        = bool
  default     = false
}

variable "backup_region" {
  description = "The region where the backup will be stored."
  type        = string
  default     = ""
}

variable "backup_start_time" {
  description = "HH:MM format (e.g. 04:00) time indicating when backup configuration starts."
  type        = string
  default     = "04:00"
}

variable "postgres_point_in_time_recovery_enabled" {
  description = "Will restart database if enabled after instance creation - only applicable to PostgreSQL"
  type        = bool
  default     = false
}

variable "mysql_binary_log_enabled" {
  description = "Set to false if you want to disable binary logs - only applicable to MySQL."
  type        = bool
  default     = false
}

variable "maintenance_window_day" {
  description = "Day of week (1-7)."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "Hour of day (0-23) on which system maintenance can occur. Ignored if 'maintenance_window_day' not set."
  type        = number
  default     = 0
}

variable "maintenance_track" {
  description = "Receive updates earlier (canary) or later (stable)."
  type        = string
  default     = "stable"
}

variable "disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The size of data disk, in GB."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The type of storage to use. Must be one of `PD_SSD` or `PD_HDD`."
  type        = string
  default     = "PD_SSD"
}

variable "master_zone" {
  description = "Preferred zone for the master instance (e.g. 'us-central1-a'). 'region'. If null, Google will auto-assign a zone."
  type        = string
  default     = null
}

variable "master_user_host" {
  description = "The host part for the default user, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. Don't set this field for Postgres instances."
  type        = string
  default     = null
}

variable "enable_public_internet_access" {
  description = "Set this to true if you want the database open to the internet."
  type        = bool
  default     = false
}

variable "enable_failover_replica" {
  description = "Set to true to enable failover replica."
  type        = bool
  default     = false
}

variable "mysql_failover_replica_zone" {
  description = "Only applicable to MySQL, Postgres will determine this automatically."
  type        = string
  default     = null
}

variable "num_read_replicas" {
  description = "The number of read replicas to create. Cloud SQL will replicate all data from the master to these replicas, which you can use to horizontally scale read traffic."
  type        = number
  default     = 0
}

variable "read_replica_zones" {
  description = "A list of compute zones where read replicas should be created. List size should match 'num_read_replicas'"
  type        = list(string)
  default     = []
}

variable "custom_labels" {
  description = "A map of custom labels to apply to the instance. The key is the label name and the value is the label value."
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance."
  type        = bool
  default     = true
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "ignore_changes" {
  type        = any
  description = "changes to ignore"
  default     = []
}
