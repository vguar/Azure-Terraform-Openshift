openshift_azure_resource_prefix = "os"

openshift_azure_resource_suffix = "acp"

openshift_azure_resource_group = "manawa-vincent"

openshift_azure_region = "eastus"

openshift_azure_tag_env = "Manawa Azure Demo"

openshift_azure_vm_username = "ocpadmin"

openshift_initial_password = "Password123"

openshift_azure_master_vm_count = 1

openshift_azure_node_vm_count = 1

openshift_azure_infra_vm_count = 1

openshift_azure_master_vm_size = "Standard_DS2_v2"

openshift_azure_data_disk_size = 128

openshift_azure_vm_os = {
  publisher = "OpenLogic"
  offer     = "CentOS"
  sku       = "7.3"
  version   = "latest"
}

openshift_master_dns_name = "osmaster"

openshift_infra_dns_name = "osinfra"

openshift_azure_default_subdomain = "xip.io"
