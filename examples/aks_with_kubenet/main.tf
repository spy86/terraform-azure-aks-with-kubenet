provider "azurerm" {
features {}
}

module "rg" {
  source  = "spy86/rg/azure"
  version = "1.0.5"
  resource_group_name = "k8s-test"
  environment = "dev" 
  region = "weu"
  resource_group_location = "West Europe"

  default_tags = {
      Administrator = "Someone"
      Department = "IT"
      CostCentre = "ABC123"
      ContactPerson = "Someone@example.com"
      ManagedByTerraform = "True"
}
}

module "virtual-network" {
  source  = "spy86/virtual-network/azure"
  version = "1.0.11"
  resource_group_name = "dev-k8s-test-weu-rg"
  environment = "dev"
  region = "weu"
  resource_group_location = "West Europe"
  vnet_address_space = "10.0.0.0/16"
  vnet_name = "VirtualNetwork"
  subnet_prefix = {
    subnet_1 = {
      ip = ["10.0.1.0/24"]
      name  = "Subnet_1"
    }
    subnet_2 = {
      ip = ["10.0.2.0/24"]
      name = "Subnet_2"
    }
    subnet_3 = {
      ip = ["10.0.3.0/24"]
      name = "Subnet_3"
    }
  }
  default_tags = {
      Administrator = "Someone"
      Department = "IT"
      CostCentre = "ABC123"
      ContactPerson = "Someone@example.com"
      ManagedByTerraform = "True"
}

depends_on = [ "module.rg" ]
}

module "aks" {
  source  = "spy86/aks-with-kubenet/azure"
  version = "1.0.2"
  resource_group_name = "dev-k8s-test-weu-rg"
  client_id = "some_client_id"
  client_secret = "some_client_secret"
  subnet_name = "Subnet_1"
  vnet_name = "dev-VirtualNetwork-weu-vnet"
  vnet_rg_name = "dev-k8s-test-weu-rg"
  network_plugin = "kubenet"
  service_cidr = "172.16.2.0/24"
  dns_service_ip = "172.16.2.11"
  docker_bridge_cidr = "172.16.1.1/24"
  load_balancer_sku = "standard"
  outbound_type = "loadBalancer"
  cluster_name = "examplecakscluster"
  log_analytics_workspace_sku = "PerGB2018"
  log_retention_in_days = 30
  admin_username = "azureadmin"
  public_ssh_key = "ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  enable_log_analytics_workspace = true
  agents_size = "Standard_B2s"
  agents_count = 1
  aks_version = "1.22.11"
  max_pods = 60
  aks_sku_tier = "Free"
  enable_attach_acr = false
  acr_id = ""

  default_tags = {
      Administrator = "Someone"
      Department = "IT"
      CostCentre = "ABC123"
      ContactPerson = "Someone@example.com"
      ManagedByTerraform = "True"
}

depends_on = [ "module.rg", "module.virtual-network"]
}