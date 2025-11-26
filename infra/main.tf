# SAMPLE Terraform: do NOT apply in limited-access environment
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-kanchandixit"
  location = "EastUS"
  tags = { 
    owner = "kanchandixit"
    environment = "demo"
  }
}
