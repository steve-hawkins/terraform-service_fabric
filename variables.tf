# General
variable "resource_group_name" {
  type        = "string"
  description = "Name of the resource group to create"
}
variable "location" {
  type        = "string"
  description = "Azure region all the resources will be deployed to"
}
variable "tags" {
  type        = "map"
  description = <<-HEREDOC
  Everything should be tagged, for guidance see:-
  https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-subscription-governance#resource-tags
  HEREDOC
}

# Networking
variable "vnet_name" {
  type        = "string"
  description = "Name of the VNet to create"
}
variable "vnet_address_space" {
  type        = "list"
  description = "VNet IP reange"
}

variable "subnet_name" {
  type        = "string"
  description = "Name of the subnet to create"
}
variable "subnet_address_prefix" {
  type        = "string"
  description = "subnet IP range"
}

variable "public_ip_name" {
  type        = "string"
  description = "Name of the public IP to create"
}
variable "public_ip_address_allocation" {
  type        = "string"
  description = "Static or Dynamic"
}

variable "load_balancer_name" {
  type        = "string"
  description = "Name of the load balancer to create"
}

# VM Scale Set
variable "vm_scale_set_name" {
  type        = "string"
  description = "Name of the VM scale set to create"
}
variable "vm_scale_set_upgrade" {
  type        = "string"
  description = "Manual or Automatic"
}
variable "vm_scale_set_capacity" {
  type        = "string"
  description = "Specify "
}
variable "vm_scale_set_tier" {
  type        = "string"
  description = "Standard, Silver or Gold"
}

# VMs
variable "vm_size" {
  type        = "string"
  description = <<-HEREDOC
  Select the size of the VMs to create:-
  https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes
  HEREDOC
}

# TODO: try out a map?
variable "vm_image_publisher" {
  type        = "string"
  description = <<-HEREDOC
  Specify the image publisher to use, see:-
  https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage
  or PowerShell:-
    $loc = [your-azure-region-here]
    $pub = 'MicrosoftWindowsServer'
    $off = 'WindowsServer'
    Get-AzureRMVMImageSku -Location $loc -Publisher $pub -Offer $off
  HEREDOC
}
variable "vm_image_offer" {
  type        = "string"
  description = <<-HEREDOC
  Specify the image offer to use, see:-
  https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage
  or PowerShell:-
    $loc = [your-azure-region-here]
    $pub = 'MicrosoftWindowsServer'
    $off = 'WindowsServer'
    Get-AzureRMVMImageSku -Location $loc -Publisher $pub -Offer $off
  HEREDOC
}
variable "vm_image_sku" {
  type        = "string"
  description = <<-HEREDOC
  Specify the image SKU to use, see:-
  https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage
  or PowerShell:-
    $loc = [your-azure-region-here]
    $pub = 'MicrosoftWindowsServer'
    $off = 'WindowsServer'
    Get-AzureRMVMImageSku -Location $loc -Publisher $pub -Offer $off
  HEREDOC
}
variable "vm_image_version" {
  type        = "string"
  description = <<-HEREDOC
  Specify the image version to use, see:-
  https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage
  or PowerShell:-
    $loc = [your-azure-region-here]
    $pub = 'MicrosoftWindowsServer'
    $off = 'WindowsServer'
    Get-AzureRMVMImageSku -Location $loc -Publisher $pub -Offer $off
  HEREDOC
}

# TODO: alternativily try Packer images?
# could be good if map works...
# variable "vm_image" {
#   type        = "string"
#   description = "name of the custom VM image to use"
# }
# variable "vm_images_resource_group_name" {
#   type        = "string"
#   description = "name of the reosurce group where custom VM images are stored"
# }

variable "vm_name_prefix" {
  type        = "string"
  description = "Prefix to the name of the VMs to create in the scale set"
}
variable "vm_admin_username" {
  type        = "string"
  description = "Username for the local administrator account"
}
variable "vm_admin_password" {
  type        = "string"
  description = "Password for the local administrator account"
}
variable "vm_os_disk_type" {
  type        = "string"
  description = "Premium_LRS is recommended"
}
variable "vm_data_disk_size" {
  type        = "string"
  description = "Size of the data disk in GB"
}
variable "vm_data_disk_type" {
  type        = "string"
  description = "Premium_LRS or Standard_LRS"
}
variable "vm_network_profile_name" {
  type        = "string"
  description = "Name of the VM network profile to create"
}
variable "vm_network_profile_ip_name" {
  type        = "string"
  description = "Name of the VM network profile IP configuration to create"
}
