output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = module.db.db_instance_endpoint
}