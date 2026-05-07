output "vpc_id"                  { value = module.network.vpc_id }
output "private_subnet_ids"      { value = module.network.private_subnet_ids }
output "cluster_name"            { value = module.compute.cluster_name }
output "cluster_endpoint"        { value = module.compute.cluster_endpoint }
output "alb_controller_role_arn" { value = module.compute.alb_controller_role_arn }
output "ecr_urls"                { value = { aide_demo_home = module.storage.ecr_aide_demo_home_url, aide_demo_platform = module.storage.ecr_aide_demo_platform_url, aide_demo_status = module.storage.ecr_aide_demo_status_url } }
