#################################################################
# Variables for Azure Registration
#################################################################
 variable "AzureSubscriptionID" {
  type    = "string"
  default = "XXXXXX"
}

variable "AzureClientID" {
  type    = "string"
  default = "XXXXX"
}

variable "AzureClientSecret" {
  type    = "string"
  default = "XXXXX"
}

variable "AzureTenantID" {
  type    = "string"
  default = "XXXX"
}


# Variable defining VM Admin Name

variable "VMAdminName" {

    type    = "string"
    default = "sm-iotdf-lab"
}

# Variable defining VM Admin password

variable "VMAdminPassword" {

    type    = "string"
    default = "Devoteam75!"
}