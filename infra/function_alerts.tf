resource "azurerm_monitor_action_group" "action_group" {
  name                 = var.exception_action_group_name
  resource_group_name = var.resource_group_name
  short_name           = var.exception_action_group_short_name
  enabled              = true

  webhook_receiver {
    name = var.exception_action_group_webhook_name
    service_uri = var.exception_action_group_service_uri
    use_common_alert_schema = var.exception_action_group_alert_schema
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "query_rules" {
  name                  = var.exception_alert_name
  resource_group_name = var.resource_group_name
  
  description           = var.exception_alert_description
  severity              = var.exception_alert_severity
  enabled               = true
  throttling = var.exception_alert_mute_duration
  data_source_id                = azurerm_application_insights.fa_insights.id
  frequency  = var.exception_alert_frequency
  time_window           = var.exception_alert_time_window
  query            = <<EOT
    union traces
    | union exceptions
    | where timestamp > ago(15m)
    | where operation_Name != ''
    | where type != ''
    | order by timestamp asc
    | project timestamp,
      message = iff(message != '', message, iff(innermostMessage != '', innermostMessage, customDimensions.['prop__{OriginalFormat}'])),
      logLevel = 'Error',
      operation_Name,
      type
    EOT
  location = "ukwest"

  trigger {
      operator         = var.exception_alert_operator
      threshold        = var.exception_alert_threshold
  }

  action {
    action_group = [azurerm_monitor_action_group.action_group.id]
  }
}
