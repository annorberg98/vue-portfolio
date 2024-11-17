terraform {
  backend "azurerm" {
    resource_group_name = "rg-neu-personalwebsite"
    storage_account_name = "antonstterraformstate"
    container_name = "terraformstate"
    key = "portfolio/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Define variables for resource names and regions
variable "location" {
  description = "Azure region for the resources"
  default     = "North Europe"  # Choose your preferred region
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "rg-neu-personalwebsite"
}

variable "static_web_app_name" {
  description = "Static Web App name"
  default     = "stapp-neu-personal-website"
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Create Static Web App
resource "azurerm_static_web_app" "static_web_app" {
  name                = var.static_web_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku_tier            = "Free"

  # Optionally provide a deployment token if available
  tags = {
    environment = "prod"
  }
}

# Outputs
output "static_web_app_url" {
  description = "The URL of the Azure Static Web App"
  value       = azurerm_static_web_app.static_web_app.default_host_name
}
