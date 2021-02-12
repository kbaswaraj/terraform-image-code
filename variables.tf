variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default = "image-rg"
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
  default = "East US"
}

variable "subscription_id" {
  type        = string
  default = "f452bc3d-52b9-4b53-bfa4-568cf5acd868"
}

variable "client_id" {
  type        = string
  default = "b1c046a3-ee83-490a-826a-731488f834db"
}

variable "client_secret" {
  type        = string
  default = "90~cXnn73rM.8334_3-HGPcXMBkQ1-T1EP"
}

variable "tenant_id" {
  type        = string
  default = "19b25223-4653-4976-90ab-252b35d5c969"
}

variable "custom_image_name" {
  type = string
  default = "custom-image"
}

variable "new_vm_name" {
  type = string
  default = "new-vm-3"
}

variable "new_storage_disk_name" {
  type = string
  default = "new-vm-storage-disk"
}

variable "new_network_interface_name" {
  type = string
  default = "image-nic3"
}

variable "new_network_interface_ip_name" {
  type = string
  default = "nic-ip"
}

variable "new_public_ip_name"{
  type = string
  default = "image-vm-ip3"
}

variable "subnet"{
  type = string
  default = "image-subnet"
}

variable "virtual_network"{
  type = string
  default = "image-vnet"
}

variable "new_user_name"{
  type = string
  default = "basawaraj"
}

variable "new_password"{
  type = string
  default = "admin@2020"
}

variable "new_computer_name"{
  type = string
  default = "New Computer"
}