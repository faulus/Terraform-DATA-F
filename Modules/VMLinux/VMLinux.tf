###################################################################################
#This module allow the creation of 1 Windows VM with 1 NIC
###################################################################################

#Variable declaration for Module

#The VM name
variable "VMName" {
  type    = "string"

}


#The VM location
variable "VMLocation" {
  type    = "string"

}

#The RG in which the VMs are located
variable "VMRG" {
  type    = "string"

}

#The NIC to associate to the VM
#variable "VMNICid" {
 # type    = "string"

#}

#The VM size
variable "VMSize" {
  type    = "string"
  default = "Standard_F1"

}


#The Availability set reference

variable "ASID" {
  type    = "string"
  
}

#The Managed Disk Storage tier

variable "VMStorageTier" {
  type    = "string"
  default = "Premium_LRS"
  
}

#The VM Admin Name

variable "VMAdminName" {
  type    = "string"
  default = "VMAdmin"
  
}

#The VM Admin Password

variable "VMAdminPassword" {
  type    = "string"
  
}

# Managed Data Disk reference

variable "DataDiskId" {
  type    = "string"

  
}

# Managed Data Disk Name

variable "DataDiskName" {
  type    = "string"

  
}

variable "DataDiskId2" {
  type    = "string"

  
}

# Managed Data Disk Name

variable "DataDiskName2" {
  type    = "string"

  
}
# Managed Data Disk size

variable "DataDiskSize" {
  type    = "string"
  
}


variable "VMPublisherName" {
  type    = "string"
  
}


variable "VMOffer" {
  type    = "string"
  
}

variable "VMsku" {
  type    = "string"
  
}

#Tag info

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#The NIC name
variable "NICName" {
  type    = "string"

}

variable "SubnetId" {
  type    = "string"

}


variable "PublicIPId" {
  type    = "string"

}

variable "NSGId" {
  type    = "string"

}

resource "azurerm_network_interface" "TerraNIC" {

 
    name                    = "${var.NICName}"
    location                = "${var.VMLocation}"
    resource_group_name     = "${var.VMRG}"
    network_security_group_id  = "${var.NSGId}"
      

    ip_configuration {

        name                                        = "ConfigIP-NIC-${var.NICName}"
        subnet_id                                   = "${var.SubnetId}"
        private_ip_address_allocation               = "dynamic"
        public_ip_address_id                        = "${var.PublicIPId}"
        #primary                                     = false        
            }

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   


}

#VM Creation


resource "azurerm_virtual_machine" "TerraVM" {

    name                    = "${var.VMName}"
    location                = "${var.VMLocation}"
    resource_group_name     = "${var.VMRG}"
    network_interface_ids   = ["${azurerm_network_interface.TerraNIC.id}"]
    vm_size                 = "${var.VMSize}"
    availability_set_id     = "${var.ASID}"
    


    storage_image_reference {
        
        publisher   = "${var.VMPublisherName}"
        offer       = "${var.VMOffer}"
        sku         = "${var.VMsku}"
        version     = "latest"

    }

    storage_os_disk {

        name                = "${var.VMName}OSDisk"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "${var.VMStorageTier}"

    }

    storage_data_disk {

        name                = "${var.DataDiskName}"
        managed_disk_id     = "${var.DataDiskId}"
        create_option       = "Attach"
        lun                 = 0
        disk_size_gb        = "${var.DataDiskSize}"
        

    }

     storage_data_disk {

        name                = "${var.DataDiskName2}"
        managed_disk_id     = "${var.DataDiskId2}"
        create_option       = "Attach"
        lun                 = 1
        disk_size_gb        = "${var.DataDiskSize}"
        

    }

    os_profile {

        computer_name   = "${var.VMName}"
        admin_username  = "${var.VMAdminName}"
        admin_password  = "${var.VMAdminPassword}"

    }

  os_profile_linux_config {
    
    disable_password_authentication = false

    }


    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
    

}


output "Name" {

  value = "${azurerm_virtual_machine.TerraVM.name}"
}

output "Id" {

  value = "${azurerm_virtual_machine.TerraVM.id}"
}

