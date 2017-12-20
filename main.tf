provider "azurerm" {

    subscription_id = "${var.AzureSubscriptionID}"
    client_id       = "${var.AzureClientID}"
    client_secret   = "${var.AzureClientSecret}"
    tenant_id       = "${var.AzureTenantID}"
}

module "ResourceGroup" {

    #Module Location
    source = "./Modules/ResourceGroup/"
    #Module variable
    RGName                  = "${var.RGName}"
    RGLocation              = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
    
}

module "vNet" {

    #Module location
    source = "./Modules/vNet/"

    #Module variable
    vNetName                = "sm-iotdf-vNet"
    RGName                  = "${module.ResourceGroup.Name}"
    vNetLocation            = "${var.AzureRegion}"
    vNetAddressSpace        = "${var.vNetIPRange}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}



