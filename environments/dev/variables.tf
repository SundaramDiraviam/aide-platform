variable "project"            { description = "Project name"; type = string }
variable "environment"        { description = "Environment name"; type = string }
variable "aws_region"         { description = "AWS region"; type = string }
variable "cluster_name"       { description = "EKS cluster name"; type = string }
variable "vpc_cidr"           { description = "VPC CIDR block"; type = string }
variable "kubernetes_version" { description = "EKS Kubernetes version"; type = string }
variable "node_instance_type" { description = "Node EC2 instance type"; type = string }
variable "node_min_size"      { description = "Minimum node count"; type = number }
variable "node_max_size"      { description = "Maximum node count"; type = number }
