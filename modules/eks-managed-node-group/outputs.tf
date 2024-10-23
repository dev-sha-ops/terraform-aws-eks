output "node_group_name" {
  description = "The name of the EKS managed node group."
  value       = aws_eks_node_group.managed_node_group.node_group_name
}

output "node_role_arn" {
  description = "The ARN of the node IAM role."
  value       = aws_iam_role.eks_node_role.arn
}

output "node_group_arn" {
  description = "The ARN of the EKS managed node group."
  value       = aws_eks_node_group.managed_node_group.arn
}
