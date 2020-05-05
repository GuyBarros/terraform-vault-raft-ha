
module "primarycluster" {
  //source       = "./module"
  source = "github.com/andrefcpimentel2/terraform-vault-raft-ha"
  zone_id      = var.zone_id
  license_file = var.license_file
  namespace    = var.namespace
  owner        = var.owner
}
