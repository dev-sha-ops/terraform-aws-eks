variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The subnets where the EKS control plane will be deployed."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed."
  type        = string
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version for your EKS cluster."
  type        = string
  default     = "1.24"
}

variable "role_policy_arn" {
  description = "The policy ARN to attach to the EKS cluster IAM role."
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  
}