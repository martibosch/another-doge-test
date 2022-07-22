output "droplet_ipv4" {
  value     = module.infrastructure.ipv4_address
  sensitive = true
}
