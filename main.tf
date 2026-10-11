resource "oci_network_firewall_network_firewall_policy_url_list" "network_firewall_network_firewall_policy_url_lists" {
  for_each = var.network_firewall_network_firewall_policy_url_lists

  name                       = each.value.name
  network_firewall_policy_id = each.value.network_firewall_policy_id
  description                = each.value.description

  dynamic "urls" {
    for_each = each.value.urls
    content {
      pattern = urls.value.pattern
      type    = urls.value.type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

