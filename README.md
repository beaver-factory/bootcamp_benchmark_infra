# Bootcamp Benchmark

## Seting Up Staging

In order to create your own deployed resource group and resources, follow these steps:
1. Create a free Azure account,
2. Add users and assign users to a group for ease of permissions granting,
3. Install AZ CLI tools and log in by running `az login`,
4. Create a service principal by following the steps in 'Adding Secrets to GitHub' and check secrets are in gh repo,
5. Create a version of `alex.az.resourcegroup.params.staging.json`, changing the name of the resource group,
6. Create a version of `alex.az.resources.params.staging.json`, again changing all of the parameter values,
  - Resource Names often have to be globally unique,
  - `AppRegistrationSPObjectID` should be taken from the portal, note: this is the App Registration Service Principal Object ID and not the App Registration Object ID.
  `DevGroupObjId` is also taken from the portal for the user group set up in step 2,
7. Update the environment variables in `deploy.yaml` accordingly,
7. Pushing to `main` should trigger `deploy.yaml` and both the resourge group and resources should then be visible in the Azure portal. 


`make creds` and `make profile`: each set github secrets for this repo

## publishing tags

`make tag v=patch`, `make tag v=minor` and `make tag v=major` will all publish new semver tags.
https://semver.org/

## Adding secrets to GitHub

Run the following command in the terminal to receive a clientSecret along with other credientials:

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
    (...)
  }
```

Finally, check the REPO_NAME variable in `set_az_cred.sh` before running `make creds` to deploy these secrets to GitHub.

## Alerts

Alerts and Action groups have most of their settings defined in the params file, however the query for the log alert is set in the `az.resources.template.json` file, to take advantage of azures multi-line string capability. This is not currently available in the params file.

The current setup for the alert is a 15 minute window (param: `"ExceptionAlertTimeWindow"`) checked every 15 minutes (param: `"ExceptionAlertFrequency"`). If an alert occurs, it will not trigger again for another 15 minutes (param: `"ExceptionAlertMuteDuration"`).



