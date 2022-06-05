resource "azurerm_kubernetes_cluster" "aks" {
  name                              = "${var.environment}-${var.cluster_name}-${var.region}-aks"
  location                          = "${data.azurerm_resource_group.rg.location}"
  resource_group_name               = "${data.azurerm_resource_group.rg.name}"
  dns_prefix                        = "${var.environment}-${var.cluster_name}"
  kubernetes_version                = "${var.aks_version}"
  private_cluster_enabled           = "${var.private_cluster_enabled}"
  sku_tier                          = "${var.aks_sku_tier}"
  role_based_access_control_enabled = "${var.rbac}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${var.public_ssh_key}"
    }
  }

  default_node_pool {
    name            = "${var.agents_name}"
    node_count      = "${var.agents_count}"
    vm_size         = "${var.agents_size}"
    os_disk_size_gb = "${var.os_disk_size_gb}"
    max_pods        = "${var.max_pods}"
    vnet_subnet_id  = "${data.azurerm_subnet.subnet.id}"
  }

  network_profile {
    network_plugin     = "${var.network_plugin}" # Values: kubenet, azure
    network_policy     = "${var.network_policy}" #Values: calico, azure, We can use only if network_plugin is set to azure
    service_cidr       = "${var.service_cidr}"
    dns_service_ip     = "${var.dns_service_ip}"
    docker_bridge_cidr = "${var.docker_bridge_cidr}"
    load_balancer_sku  = "${var.load_balancer_sku}" #Values: basic, standard
    outbound_type      = "${var.outbound_type}" # Values: loadBalancer and userDefinedRouting. Defaults to loadBalancer. We can use only if network_plugin is set to azure
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  oms_agent {
    log_analytics_workspace_id = "${azurerm_log_analytics_workspace.main[0].id}"
  }


  tags = "${var.default_tags}"
}

resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}


resource "azurerm_log_analytics_workspace" "main" {
  count               = "${var.enable_log_analytics_workspace}" ? 1 : 0
  name                = "${var.cluster_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = "${data.azurerm_resource_group.rg.location}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  sku                 = "${var.log_analytics_workspace_sku}"
  retention_in_days   = "${var.log_retention_in_days}"

  tags = "${var.default_tags}"

}

resource "azurerm_log_analytics_solution" "main" {
  count                 = "${var.enable_log_analytics_workspace}" ? 1 : 0
  solution_name         = "${var.solution_name}"
  location              = "${data.azurerm_resource_group.rg.location}"
  resource_group_name   = "${data.azurerm_resource_group.rg.name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.main[0].id}"
  workspace_name        = "${azurerm_log_analytics_workspace.main[0].name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}


