###########################
# Common vars
###########################
variable "environment" {
  description = "Var used for backend container name key"
  type = string
  default = "dev"
}
variable "default_tags" {
  description = "A mapping of tags to assign to the resource."
  type = map
  default = null
}
variable "region" {
  description = "Region in which resources are deployed"
  type = string
  default = "weu"
}
###########################
# Resource groups vars
###########################
variable "resource_group_location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default = "West Europe"
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type = string
}
###########################
# AKS vars
###########################
variable "cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  type = string
}
variable "client_id" {
  description = "The Client ID for the Service Principal."
  type = string
}
variable "client_secret" {
  description = "The Client Secret for the Service Principal."
  type = string
}
variable "admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created."
  type = string
  default = "azureadmin"
}
variable "agents_size" {
  description = "The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created."
  type = string
  default = "Standard_B2s"
}
variable "log_analytics_workspace_sku" {
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  type = string
  default = "PerGB2018"
}
variable "log_retention_in_days" {
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type = number
  default = 30
}
variable "agents_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count."
  type = number
  default = 1
}
variable "public_ssh_key" {
  description = "The Public SSH Key used to access the cluster. Changing this forces a new resource to be created."
  type = string
  default = null
}
variable "enable_log_analytics_workspace" {
  description = "Enable the creation of azurerm_log_analytics_workspace and azurerm_log_analytics_solution or not"
  type = bool
  default = true
}
variable "solution_name" {
  description = "Specifies the name of the solution to be deployed. See here for options.Changing this forces a new resource to be created."
  type = string
  default = "ContainerInsights"
}
variable "aks_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  type = string
  default = "1.22.7"
}
variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  type = bool
  default = false
}
variable "rbac" {
  description = " Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created."
  type = bool
  default = true
}
variable "agents_name" {
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  type = string
  default = "nodepool"
}
variable "os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created."
  type = number
  default = 120
}
variable "subnet_name" {
  description = "The name of the subnet."
  type = string
}
variable "vnet_name" {
  description = "The name of the Virtual Network"
  type = string
}
variable "vnet_rg_name" {
  description = "Specifies the Resource Group where the Virtual Network should exist."
  type = string
}
variable "network_plugin" {
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
  type = string
  default = "kubenet"
}
variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
  type = string
  default = null
}
variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  type = string
  default = "172.16.2.0/24"
}
variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  type = string
  default = "172.16.2.11"
}
variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  type = string
  default = "172.16.1.1/24"
}
variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard."
  type = string
  default = "standard"
}
variable "outbound_type" {
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer."
  type = string
  default = "loadBalancer"
}
variable "max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type = number
  default = 60
}
variable "aks_sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  type = string
  default = "Free"
}
variable "enable_attach_acr" {
  description = "Enable ACR Pull attach. Needs acr_id to be defined."
  type        = bool
  default     = false
}

variable "acr_id" {
  description = "Attach ACR ID to allow ACR Pull from the SP/Managed Indentity."
  type        = string
  default     = ""
}