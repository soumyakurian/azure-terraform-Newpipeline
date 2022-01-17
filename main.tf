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
terraform {
  backend "azurerm" {
    resource_group_name  = "TF_Rg_Blobstore"
    storage_account_name = "tfstorageacntsk23663456"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  
}

variable "imagebuild" {
  type        = string
  description = "latest image build"
}

resource "azurerm_resource_group" "TF_Test" {
  name     = "TF_AzureRG"
  location = "West US"
}

resource "azurerm_container_group" "TFCG_Test" {
  name                = "weatherapi"
  location            = azurerm_resource_group.TF_Test.location
  resource_group_name = azurerm_resource_group.TF_Test.name
  ip_address_type     = "public"
  dns_name_label      = "sk23663456weatherapi"
  os_type             = "Windows"
  container {
    name   = "weatherapi"
    image  = "sk23663456/weatherapi:${var.imagebuild}"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = "80"
      protocol = "TCP"
    }

  }
}
