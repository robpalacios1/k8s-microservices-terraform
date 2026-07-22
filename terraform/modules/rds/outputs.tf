output "db_endpoint" {
  description = "Endpoint Cnnection from RDS DataBase"
  value = aws_db_instance.main.endpoint
}

output "db_name" {
  description = "DataBase Name"
  value = aws_db_instance.main.db_name
}

output "db_instance_id" {
  description = "RDS Instance ID"
  value = aws_db_instance.main.id
}
