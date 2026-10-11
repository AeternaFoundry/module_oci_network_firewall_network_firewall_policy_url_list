variable "network_firewall_network_firewall_policy_url_lists" {
  description = <<EOT
Map of network_firewall_network_firewall_policy_url_lists, attributes below
Required:
    - name
    - network_firewall_policy_id
    - urls (block):
        - pattern (required)
        - type (required)
Optional:
    - description
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name                       = string
    network_firewall_policy_id = string
    description                = optional(string)
    urls = list(object({
      pattern = string
      type    = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_url_lists : (
        length(v.urls) >= 1
      )
    ])
    error_message = "Each urls list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_url_lists : (
        alltrue([for item in v.urls : (contains(["SIMPLE"], item.type))])
      )
    ])
    error_message = "must be one of: \"SIMPLE\""
  }
}

