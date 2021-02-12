provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

data "azurerm_shared_image" "search" {
  name                = var.custom_image_name
  gallery_name = "myGallery"
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
    name = var.subnet
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.virtual_network

}

# Creating Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = var.new_public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = {
    environment = "production"
  }
}

# Creating a network interface
resource "azurerm_network_interface" "nic" {
  name                = var.new_network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.new_network_interface_ip_name
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.public_ip.id}"
  }

  tags = {
    environment = "production"
  }
}

# Creating VM from custom image
resource "azurerm_virtual_machine" "vm" {
  name                             = var.new_vm_name
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = "Standard_DS12_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "${data.azurerm_shared_image.search.id}"
  }

  storage_os_disk {
    name = var.new_storage_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
}

  os_profile {
    computer_name  = var.new_computer_name
    admin_username = var.new_user_name
    admin_password = var.new_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

output "network_interface_id" {
    value = "${azurerm_network_interface.nic.id}"
}

output "new_vm_id" {
    value = "${azurerm_virtual_machine.vm.id}"
}