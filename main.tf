resource "random_string" "cluster_id" {
  length  = 8
  special = false
  upper   = false
}

resource "random_pet" "cluster_name" {
  length    = 2
  separator = "-"
}
