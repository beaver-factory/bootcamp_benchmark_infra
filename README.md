# Bootcamp Benchmark

## Setting Up Staging

In order to create your own deployed resource group and resources, follow these steps:

1. Create a free Azure account,
2. Add users and assign users to a group for ease of permissions granting (contributor access at the subscription level allows users to interact with all resource groups and resources in the subscription for getting started),
3. Create an App Registration via the portal,
4. Install AZ CLI tools and log in by running `az login`,
5. Create a backend to hold the terraform state by running `make setup_tf_backend`

   - this will deploy infrastructure to a separate resource group in Azure that is responsible for holding the Terraform state for the Bootcamp Benchmark project.
   - it will also create a `main.tf` that will hold the required config to connect to this backend.

6. Create a workflow to process function error handling by following the steps in 'Creating Power Automate Flow',
7. Create a service principal by following the steps in 'Adding Secrets to GitHub' and check secrets are in the GitHub repos,
8. Update the variable names in `az.variables_stag.tfvars` and `az.variables_prod.tfvars`, note:

   - Resource Names often have to be globally unique,
   - `dev_group_obj_id` is taken from the portal for the user group set up in step 2,
   - `app_registration_sp_object_id` should also be taken from the portal from step 3, note: this is the App Registration Service Principal Object ID and not the App Registration Object ID,

9. Opening a PR to main will trigger `tf-plan.yaml` and result in a comment on the PR to show the Terraform plan,
10. Pushing to `main` will trigger `deploy.yaml` and both the resource group and resources will then be visible in the Azure portal.

## Publishing tags

`make tag v=patch`, `make tag v=minor` and `make tag v=major` will all publish new semver tags.
https://semver.org/

## Creating Power Automate Flow

The HTTP POST URL of a Power Automate Flow trigger can be used whenever a function fails to trigger a customised response, eg sending a Slack message. After accessing Power Apps:

1. Go to flows,
2. Make new flow, give it a name
3. Go to the next step and select HTTP request as a trigger
4. Save the flow, this will generate the URL.
5. Do whatever you want with the output of the http request trigger in the flow editor

Make sure you copy the HTTP POST URL of the trigger and save it in a local `.env` with the name of `EXCEPTION_ACTION_GROUP_SERVICE_URI`.

## Adding secrets to GitHub

This process will add both sensitive variables required by Terraform and Azure credentials to GitHub secrets.

First, make sure your local `.env` file has a value for `EXCEPTION_ACTION_GROUP_SERVICE_URI` as per the steps in 'Creating Power Automate Flow'. Then add a second variable called `PSQL_PASSWORD` which will be the admin password for the Azure PSQL database.

Then, run the following command in the terminal to receive a `clientSecret` (along with other credientials which can also be found in the portal):

```
az ad sp create-for-rbac --name "{App Name}" --role contributor \
                            --scopes /subscriptions/{subscriptionID} \
                            --sdk-auth

```

**_Be sure to copy the clientSecret as it is not visible in the portal!_** Then make a local `creds.json` with the following properties:

```
{
    "clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
  }
```

Finally, check the `GH_INFRA_REPO` and `GH_FUNC_REPO` variables in `set_az_cred.sh` before running `make creds` to deploy the relevant secrets to both the infra and functions repos that are needed by the deployment workflows.

## Alerts

Alerts and Action groups have most of their settings defined in the variables files, however the query for the log alert is set in the `az.function_alerts.tf` file, to take advantage of terraform's multi-line string capability.

The current setup for the alert is a 15 minute window (param: `"ExceptionAlertTimeWindow"`) checked every 15 minutes (param: `"ExceptionAlertFrequency"`). If an alert occurs, it will not trigger again for another 15 minutes (param: `"ExceptionAlertMuteDuration"`).
