resource "azurerm_role_assignment" "attach_acr" {
  count = "${var.enable_attach_acr}" ? 1 : 0

  scope                = "${var.acr_id}"
  role_definition_name = "AcrPull"
  principal_id         = "${azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id}"

depends_on = [ azurerm_kubernetes_cluster.aks ]
}