output "cluster_id" {
  value       = random_string.cluster_id.result
  description = "The generated cluster ID"
}

output "cluster_name" {
  value       = random_pet.cluster_name.id
  description = "The generated cluster name"
}
