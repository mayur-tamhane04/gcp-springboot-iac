output "postgres_ip" {
  value = google_sql_database_instance.instance.ip_address.0.ip_address
}

output "postgres_user_name" {
  value = google_sql_user.sql_user.name
}

output "postgres_user_password" {
  value = google_sql_user.sql_user.password
}

output "postgres_db_name" {
  value = google_sql_database.database.name
}