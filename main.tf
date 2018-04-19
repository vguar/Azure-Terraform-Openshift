resource "azurerm_resource_group" "myterraformgroup" {
    name     = "manawa-vincent"
    location = "eastus"

    tags {
        environment = "Manawa Azure Demo"
    }
}
