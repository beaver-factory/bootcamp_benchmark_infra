# RESOURCE GROUP
variable "resource_group_name" {
  type    = string
  default = "TFBootcampBenchmarkStaging"
}

# STORAGE
variable "storage_account_name" {
  type    = string
  default = "bootcampbstorageaccstag3"
}

variable "blob_container1" {
  type    = string
  default = "rawblobcontainer"
}

variable "blob_container2" {
  type    = string
  default = "processedblobcontainer"
}

variable "blob_container3" {
  type    = string
  default = "utilblobcontainer"
}

# MISC
variable "fa_insights_name" {
  type    = string
  default = "bb-insights-stag3"
}

variable "fa_server_farm_name" {
  type    = string
  default = "bb-serverfarm-stag3"
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "app_registration_sp_object_id" {
  type    = string
  default = "f37e41fb-5bd7-419f-9a55-ef97077bc858"
}

variable "dev_group_obj_id" {
  type    = string
  default = "a67a2672-8b1e-487a-8485-9076bf501ec1"
}

# FUNCTION APPS
variable "collectors_fa_name" {
  type    = string
  default = "bb-collectors-stag3"
}

variable "processors_fa_name" {
  type    = string
  default = "bb-processors-stag3"
}

variable "loaders_fa_name" {
  type    = string
  default = "bb-loaders-stag3"
}

# KEYVAULT
variable "keyvault_name" {
  type    = string
  default = "bootcampbkeyvaultstag3"
}

variable "key_vault_enabled_for_deployment" {
  type    = bool
  default = false
}

variable "key_vault_enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "key_vault_enabled_for_template_deployment" {
  type    = bool
  default = false
}


# POSTGRES

variable "admin_login" {
  type    = string
  default = "bootcampb_admin"
}

variable "admin_password" {
  type    = string
  default = "secret_password123"
}

variable "postgres_server_name" {
  type    = string
  default = "bootcampbpsqlserverstag3"
}

variable "postgres_db_name" {
  type    = string
  default = "bootcampbpsqldbstag"
}

# ALERTS

variable "exception_alert_name" {
  type    = string
  default = "bb-exceptionAlert-stag3"
}

variable "exception_alert_description" {
  type    = string
  default = "Alerts users when a function fails to run correctly (i.e when an exception is raised)"
}

variable "exception_alert_severity" {
  type    = number
  default = 1
}

variable "exception_alert_frequency" {
  type    = string
  default = 15
}

variable "exception_alert_time_window" {
  type    = string
  default = 15
}

variable "exception_alert_mute_duration" {
  type    = string
  default = 15
}

variable "exception_alert_threshold" {
  type    = number
  default = 0
}

variable "exception_alert_operator" {
  type    = string
  default = "GreaterThan"
}

variable "exception_alert_time_agg" {
  type    = string
  default = "Count"
}

variable "exception_action_group_name" {
  type    = string
  default = "bb-exceptionAlertsGroup-stag3"
}

variable "exception_action_group_short_name" {
  type    = string
  default = "bb-eag-stag3"
}

variable "exception_action_group_webhook_name" {
  type    = string
  default = "powerAutomateEmailAlert"

}

variable "exception_action_group_service_uri" {
  type    = string
  default = "https://prod-27.uksouth.logic.azure.com:443/workflows/b61f03a573534af9b9702cf50161bc25/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=KDBfTIaGGu-z17_LmQQeQNW9etMVxcPIFGTbs4xD0_o"
}

variable "exception_action_group_alert_schema" {
  type    = bool
  default = true

}