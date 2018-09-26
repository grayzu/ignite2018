resource "azurerm_container_group" "ghost" {
    name                    = "ghost"
    location                = "${var.loc}"
    resource_group_name     = "${azurerm_resource_group.ig2018-rg.name}"
    ip_address_type         = "public"
    os_type                 = "linux"
    tags                    = "${var.tags}"

    container {
        name                    = "ghost-blog"
        image                   = "ghost:alpine"
        cpu                     = "0.5"
        memory                  = "1.0"
        port                    = "2368"

        # environment_variables {
        #     "database__client"                  = "mysql"
        #     "database__connection__host"        = "db"
        #     "database__connection__user"        = "root"
        #     "database__connection__password"    = "example"
        #     "database__connection__database"    = "ghost"
        # }
    }
}

resource "azurerm_traffic_manager_endpoint" "ig2018pnwrider-fe" {
  name                      = "pnwrider-fe"
  resource_group_name       = "${var.rg}"
  profile_name              = "${azurerm_traffic_manager_profile.ig2018pnwrider.name}"
  type                      = "azureEndpoints"
  target_resource_id        = "${azurerm_container_group.ghost.id}"
  weight                    = 100
}