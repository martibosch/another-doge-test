terraform {
  cloud {
    organization = "exaf-epfl"
    workspaces {
      name = "another-doge-test"
    }
  }
}
