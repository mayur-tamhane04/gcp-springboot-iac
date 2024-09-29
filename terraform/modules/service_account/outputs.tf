output "service_account_email" {
  value = google_service_account.service_account.email
}

output "service_account_id" {
  value = google_service_account.service_account.id
}