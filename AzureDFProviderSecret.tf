#################################################################
# Variables for Azure Registration
#################################################################


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