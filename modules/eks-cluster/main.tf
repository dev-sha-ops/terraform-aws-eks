resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  version = var.kubernetes_version

  tags = merge(
    {
      "Name" = var.cluster_name
    },
    var.tags
  )
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-${var.environment}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy" {
  for_each = toset(var.role_policy_arn)
  role     = aws_iam_role.eks_cluster_role.name
  policy_arn = each.value
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-${var.environment}}-sg"
  description = "EKS Cluster security group"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = "${var.cluster_name}-${var.environment}}-sg"
    },
    var.tags
  )
}
