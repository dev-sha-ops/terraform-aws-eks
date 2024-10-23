variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of the node group."
  type        = string
}

variable "subnet_ids" {
  description = "The subnets where the EKS worker nodes will be deployed."
  type        = list(string)
}

variable "instance_types" {
  description = "The EC2 instance types for the nodes."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "The desired number of nodes in the worker group."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of nodes in the worker group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of nodes in the worker group."
  type        = number
  default     = 3
}

variable "ami_type" {
  description = "The AMI type to use for the instances (AL2_x86_64, AL2_x86_64_GPU, etc.)."
  type        = string
  default     = "AL2_x86_64"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  
}