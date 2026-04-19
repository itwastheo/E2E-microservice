output "cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "node_security_group_id" {
  description = "Security group ID for the EKS worker nodes."
  value       = module.eks.node_security_group_id
}