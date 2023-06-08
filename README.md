# Bootcamp Benchmark

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
***Be sure to copy the clientSecret as it is not visible in the portal!*** Then make a local `creds.json` with the following properties:
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