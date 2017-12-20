##################################################################################
#Creating VM 1
##################################################################################



#Datadisk creation

module "Datadisk-VM-sm-iotdf" {

    #Module Location
    source = "./Modules/ManagedDisk/"    
    
    #Module variable
    Manageddiskcount    = "1"
    ManageddiskName     = "DataDisk_iotdf"
    RGName              = "${module.ResourceGroup.Name}"
    ManagedDiskLocation = "${var.AzureRegion}"
    StorageAccountType  = "${lookup(var.Manageddiskstoragetier, 1)}"
    CreateOption        = "Empty"
    DiskSizeInGB        = "62"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"

}


#Datadisk 2 creation
module "Datadisk2-VM-sm-iotdf" {

#
    #Module Location
   source = "./Modules/ManagedDisk/"    
    
    ####Module variable
    Manageddiskcount    = "1"
    ManageddiskName         = "VM-sm-iotdf-Datadisk2"
    RGName                  = "${module.ResourceGroup.Name}"
    ManagedDiskLocation     = "${var.AzureRegion}"
    StorageAccountType      = "${lookup(var.Manageddiskstoragetier, 1)}"
    CreateOption            = "empty"
    DiskSizeInGB            = "62"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
}

module "VM-sm-iotdf-AS" {

    #module location
    source = "./Modules/AvailabilitySet"
    #source = "github.com/dfrappart/Terra-AZModuletest//Modules//AvailabilitySet/"

    #Module variable
    ASName                      = "VM-sm-iotdf-AS"
    ASLocation                  = "${module.ResourceGroup.Location}"
    RGName                      = "${module.ResourceGroup.Name}"

}

#Public IP Creation

module "PublicIP" {

    #Module Location
    source = "Modules/PublicIP"

    #Module variables
    PublicIPName            = "sm-iotdf-publicip"
    PublicIPLocation        = "${module.ResourceGroup.Location}"
    RGName                  = "${module.ResourceGroup.Name}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
}


resource "azurerm_network_security_group" "Terra-NSG2" {

    name                = "test"
    location            = "${module.ResourceGroup.Location}"
    resource_group_name = "${module.ResourceGroup.Name}"


    tags {
        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
    }  
}


module "NSGRule" {

    #Module location
    source = "./Modules/NSG"

    #Module variable
    RGName                  = "${module.ResourceGroup.Name}"
    NSGRuleName                 = "NSG"
    NSGLocation             = "${module.ResourceGroup.Location}"
    EnvironmentTag          = "Lab-Moduletest"
    EnvironmentUsageTag     = "Lab only"
    NSGRulePriority         = "101"
    NSGRuleDirection        = "Inbound"
    NSGRuleAccess           = "Allow"
    NSGRuleProtocol         = "TCP"
    NSGRuleSourcePortRange  = "*"
    NSGRuleDestinationPortRange = "443"
    NSGRuleSourceAddressPrefix = "Internet"
    NSGRuleDestinationAddressPrefix = "*"
    NSGReference            = "test"

}
module "Subnet" {

    #Module location
    source = "./Modules/Subnet"
    
    #Module variable
    SubnetName                  = "Subnet"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.vNet.Name}"
    Subnetaddressprefix         = "10.0.0.0/24"
    NSGid                       = "${azurerm_network_security_group.Terra-NSG2.id}"
    EnvironmentTag              = "Lab-Moduletest"
    EnvironmentUsageTag         = "Lab only"

}

module "VM-sm-iotdf" {

    #Module location
   source = "/Modules/VMLinux"
    

   # #Module variables
    VMName              = "VM-sm-iotdf"
    VMLocation          = "${module.ResourceGroup.Location}"
    VMRG                = "${module.ResourceGroup.Name}"
    NICName             = "NIC-VM-sm-iotdf"
    VMSize              = "${lookup(var.VMSize, 0)}"
    ASID                = "${module.VM-sm-iotdf-AS.Id}"
    VMPublisherName     = "${lookup(var.PublisherName,2)}"
    VMOffer             = "${lookup(var.Offer, 2)}"
    VMsku               = "${lookup(var.sku, 0)}"
    VMStorageTier       = "${lookup(var.Manageddiskstoragetier, 0)}"
    VMAdminName         = "${var.VMAdminName}"  
    VMAdminPassword     = "${var.VMAdminPassword}"
    DataDiskName        = "${module.Datadisk-VM-sm-iotdf.Name}"
    DataDiskId          = "${module.Datadisk-VM-sm-iotdf.Id}"
    DataDiskSize        = "${module.Datadisk-VM-sm-iotdf.Size}"
    DataDiskName2        = "${module.Datadisk2-VM-sm-iotdf.Name2}"
    DataDiskId2          = "${module.Datadisk2-VM-sm-iotdf.Id2}"
    DataDiskSize        = "${module.Datadisk2-VM-sm-iotdf.Size}"
    PublicIPId          = "${module.PublicIP.Id}"
   SubnetId           = "${module.Subnet.Id}"
   NSGId                = "${azurerm_network_security_group.Terra-NSG2.id}"

}