###########################
## Getting the VPC info. ##
###########################

data "google_compute_network" "network" {
  project = var.project_id
  name    = var.network_name
}

resource "google_compute_global_address" "psc_ip_addr" {
  name          = "psc-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = data.google_compute_network.network.id
}

resource "google_service_networking_connection" "default" {
  network                 = data.google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.psc_ip_addr.name]
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering = google_service_networking_connection.default.peering
  network = data.google_compute_network.network.name

  import_custom_routes = true
  export_custom_routes = true
}