# Create network interface
resource "azurerm_network_interface" "osmasternic" {
  name                      = "nic-master-${var.openshift_azure_resource_suffix}-${format("%01d", count.index)}"
  count                     = "${var.openshift_azure_master_vm_count}"
  location                  = "eastus"
  resource_group_name       = "${azurerm_resource_group.myterraformgroup.name}"
  network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
    private_ip_address_allocation = "dynamic"
  }

  tags {
    environment = "Manawa Azure Demo"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "osmastervm" {
  name                  = "${var.openshift_azure_resource_prefix}-vm-master-${var.openshift_azure_resource_suffix}-${format("%01d", count.index)}"
  count                 = "${var.openshift_azure_master_vm_count}"
  location              = "${var.openshift_azure_region}"
  resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
  network_interface_ids = ["${azurerm_network_interface.osmasternic.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.openshift_azure_resource_prefix}-disk-os-master-${var.openshift_azure_resource_suffix}-${format("%01d", count.index)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "${var.openshift_azure_vm_os["publisher"]}"
    offer     = "${var.openshift_azure_vm_os["offer"]}"
    sku       = "${var.openshift_azure_vm_os["sku"]}"
    version   = "${var.openshift_azure_vm_os["version"]}"
  }

  os_profile {
    computer_name  = "${var.openshift_azure_resource_prefix}-vm-master-${var.openshift_azure_resource_suffix}-${format("%01d", count.index)}"
    admin_username = "${var.openshift_azure_vm_username}"
    admin_password = "${var.openshift_initial_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    ssh_keys {
      path     = "/home/ocpadmin/.ssh/authorized_keys"
      key_data = "ssh-rsa SNIP"
    }
  }

  tags {
    environment = "Manawa Azure Demo"
  }
}
