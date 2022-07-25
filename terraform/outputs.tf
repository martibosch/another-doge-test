output "ssh_private_key" {
  value     = module.base.ssh_private_key
  sensitive = true
}

output "droplet_ipv4" {
  value     = module.infrastructure.ipv4_address
  sensitive = true
}
