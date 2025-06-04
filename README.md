# Bitwarden Secrets Manager - Fetch All Secrets Action

A GitHub Action that fetches all secrets from Bitwarden Secrets Manager and makes them available as environment
variables in your GitHub Actions workflow.

## Description

This action connects to Bitwarden Secrets Manager using the provided access token, retrieves all accessible secrets, and
exports them as environment variables. This allows you to securely use your Bitwarden-stored secrets in your GitHub
Actions workflows without having to manually configure each secret in GitHub.

## Prerequisites

- A Bitwarden Secrets Manager account
- A Bitwarden Secrets Manager access token

## Usage

Add the following step to your GitHub Actions workflow:

```yaml
- name: Fetch Bitwarden Secrets
  uses: miketako3/bitwarden-sm-fetch-all-secrets-action@v1
  with:
    access_token: ${{ secrets.BITWARDEN_ACCESS_TOKEN }}
```

After this step, all your Bitwarden secrets will be available as environment variables in subsequent steps of your
workflow.

## Inputs

| Input          | Description                            | Required | Default |
|----------------|----------------------------------------|----------|---------|
| `access_token` | Bitwarden Secrets Manager Access Token | Yes      | N/A     |

## How it works

1. The action authenticates with Bitwarden Secrets Manager using the provided access token
2. It retrieves a list of all secrets accessible with that token
3. For each secret, it fetches the value and exports it as an environment variable
4. The environment variable name will be the same as the secret name in Bitwarden

## Example

```yaml
name: Deploy with Bitwarden Secrets

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Fetch Bitwarden Secrets
        uses: miketako3/bitwarden-sm-fetch-all-secrets-action@v1
        with:
          access_token: ${{ secrets.BITWARDEN_ACCESS_TOKEN }}

      - name: Deploy with secrets
        run: |
          # Now you can use the secrets as environment variables
          echo "Deploying with API key: $API_KEY"
          # If you have a secret named DATABASE_URL in Bitwarden, you can use it as:
          # $DATABASE_URL
```

## Security Notes

- The access token should be stored as a GitHub secret
- This action will export ALL secrets accessible with the provided token
- Secret values are not printed to logs, but secret names are visible in the logs

## License

[MIT](LICENSE)
