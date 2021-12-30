terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "TF_Test" {
  name     = "TF_AzureRG"
  location = "West US"
}

resource "azurerm_container_group" "TFCG_Test"{
  name                = "weatherapi"
  location            = azurerm_resource_group.TF_Test.location
  resource_group_name         = azurerm_resource_group.TF_Test.name
  ip_address_type     = "public"
  dns_name_label      = "sk23663456weatherapi"
  os_type             = "Windows"
  container {
    name   = "weatherapi"
    image  = "sk23663456/weatherapi"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = "80"
      protocol = "TCP"
    }

  }
}
