###################################################################
#This module allow the creation of a Managed disk with count option
###################################################################

#Variable declaration for Module

#The count value
variable "Manageddiskcount" {
  type    = "string"

}


#The Managed Disk name
variable "ManageddiskName" {
  type    = "string"

}

#The RG in which the MD is attached to
variable "RGName" {
  type    = "string"

}

#The location in which the MD is attached to
variable "ManagedDiskLocation" {
  type    = "string"

}

#The underlying Storage account type. Value accepted are Standard_LRS and Premium_LRS
variable "StorageAccountType" {
  type    = "string"

}
#The create option. Value accepted
#Import - Import a VHD file in to the managed disk (VHD specified with source_uri).
#Empty - Create an empty managed disk.
#Copy - Copy an existing managed disk or snapshot (specified with source_resource_id). 

variable "CreateOption" {
  type    = "string"

}

# Specifies the size of the managed disk to create in gigabytes. 
#If create_option is Copy, then the value must be equal 
#to or greater than the source's size.
#Take also into account the pricing related to the size:
#129 GB equal 512 Provisioned so prefer 
#corresponding value to storage tiers desired

variable "DiskSizeInGB" {
  type    = "string"

}


variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}





#ManagedDisk creation

resource "azurerm_managed_disk" "TerraManagedDiskwithcount" {


    count                   = "${var.Manageddiskcount}"
    name                    = "${var.ManageddiskName}${count.index+1}"
    location                = "${var.ManagedDiskLocation}"
    resource_group_name     = "${var.RGName}"
    storage_account_type    = "${var.StorageAccountType}"
    create_option           = "${var.CreateOption}"
    disk_size_gb            = "${var.DiskSizeInGB}"

    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
    
}


#Output

output "Names" {

  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.name}"]
}

output "Ids" {

  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.id}"]
}

output "Sizes" {

  value = ["${azurerm_managed_disk.TerraManagedDiskwithcount.*.disk_size_gb}"]
}