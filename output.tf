output "client_key" {
    description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}"
    sensitive = true
}
output "client_certificate" {
    description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
    sensitive = true
}

output "cluster_ca_certificate" {
    description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}"
    sensitive = true
}

output "cluster_username" {
    description = "A username used to authenticate to the Kubernetes cluster."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.username}"
    sensitive = false
}

output "cluster_password" {
    description = "A password or token used to authenticate to the Kubernetes cluster."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.password}"
    sensitive = true
}

output "kube_config" {
    description = "A kube_config block as defined below."
    value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
    sensitive = true
}

output "host" {
    description = "The Kubernetes cluster server host."
    value = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
    sensitive = false
}