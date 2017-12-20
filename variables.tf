
variable "AzureRegion" {

    type    = "string"
    default = "westeurope"
}

# Variable to define the Tag

variable "EnvironmentTag" {

    type    = "string"
    default = "sm-iotdf-lab"
}

variable "EnvironmentUsageTag" {

    type    = "string"
    default = "sm-iotdf-lab"
}

variable "RGName" {

    type    = "string"
    default = "alstom-sm-iotdf"
}

variable "vNetIPRange" {

    type = "list"
    default = ["10.0.0.0/24"]
}

variable "SubnetAddressRange" {
#Note: Subnet must be in range included in the vNET Range
    
    default = {
      "0" = "10.0.0.0/24"

    }
}

variable "SubnetName" {
    
    default = {
      "0" = "Default"

    }
}


# variable defining storage account tier

variable "storageaccounttier" {

    
    default = {
      "0" = "standard_lrs"
      "1" = "premium_lrs"
      "2" = "standard_grs"
      "3" = "premium_grs"
     }
}

# variable defining storage account tier for managed disk

variable "Manageddiskstoragetier" {

    
    default = {
      "0" = "standard_LRS"
      "1" = "premium_lrs"

    }
}

#variable defining VM size
variable "VMSize" {
 
  default = {
      "0" = "Standard_D4s_v3"

  }
}

# variable defining VM image 

variable "PublisherName" {

    
    default = {
      "0" = "microsoftwindowsserver"
      "1" = "MicrosoftVisualStudio"
      "2" = "canonical"
      "3" = "credativ"

    }
}

variable "Offer" {

    
    default = {
      "0" = "WindowsServer"
      "1" = "Windows"
      "2" = "ubuntuserver"
      "3" = "debian"

    }
}

variable "sku" {

    
    default = {
      "0" = "16.04-LTS"

    }
}