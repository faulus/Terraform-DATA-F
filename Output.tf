######################################################
# This file defines which value are sent to output
######################################################

######################################################
# Resource group info Output

output "ResourceGroupName" {

    value = "${module.ResourceGroup.Name}"
}

output "ResourceGroupId" {

    value = "${module.ResourceGroup.Id}"
}

######################################################
# vNet info Output

output "vNetName" {

    value = "${module.vNet.Name}"
}

output "vNetId" {

    value = "${module.vNet.Id}"
}

output "vNetAddressSpace" {

    value = "${module.vNet.AddressSpace}"
}

######################################################
# VM info Output

output "IPpublic" {

    value = "${module.PublicIP.Id}"
}


