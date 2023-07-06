# RESOURCE GROUP
resource_group_name = "TFBootcampBenchmarkProd"


# STORAGE
storage_account_name = "bootcampbstorageaccprod3"


blob_container1 = "rawblobcontainer"


blob_container2 = "processedblobcontainer"


blob_container3 = "utilblobcontainer"


# MISC
fa_insights_name = "bb-insights-prod3"


fa_server_farm_name = "bb-serverfarm-prod3"


sku_name = "standard"


app_registration_sp_object_id = "f37e41fb-5bd7-419f-9a55-ef97077bc858"


dev_group_obj_id = "a67a2672-8b1e-487a-8485-9076bf501ec1"


# FUNCTION APPS
collectors_fa_name = "bb-collectors-prod3"


processors_fa_name = "bb-processors-prod3"


loaders_fa_name = "bb-loaders-prod3"


# KEYVAULT
keyvault_name = "bootcampbkeyvaultprod3"

key_vault_enabled_for_deployment = false

key_vault_enabled_for_disk_encryption = false

key_vault_enabled_for_template_deployment = false



# POSTGRES
admin_login = "bootcampb_admin"

admin_password = "secret_password123"

postgres_server_name = "bootcampbpsqlserverprod3"

postgres_db_name = "bootcampbpsqldbprod"


# ALERTS
exception_alert_name = "bb-exceptionAlert-prod3"

exception_alert_description = "Alerts users when a function fails to run correctly (i.e when an exception is raised)"

exception_alert_severity = 1

exception_alert_frequency = 15

exception_alert_time_window = 15

exception_alert_mute_duration = 15

exception_alert_threshold = 0

exception_alert_operator = "GreaterThan"

exception_alert_time_agg = "Count"

exception_action_group_name = "bb-exceptionAlertsGroup-prod3"

exception_action_group_short_name = "bb-eag-prod3"

exception_action_group_webhook_name = "powerAutomateEmailAlert"


exception_action_group_service_uri = "https://prod-27.uksouth.logic.azure.com:443/workflows/b61f03a573534af9b9702cf50161bc25/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=KDBfTIaGGu-z17_LmQQeQNW9etMVxcPIFGTbs4xD0_o"

exception_action_group_alert_schema = true

