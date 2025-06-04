#!/bin/bash

set -e

ACCESS_TOKEN="$1"

export BWS_ACCESS_TOKEN="$ACCESS_TOKEN"

# Fetch all secrets and export as environment variables
secrets_json=$(bws secret list --json)

for row in $(echo "$secrets_json" | jq -r '.[] | @base64'); do
  _jq() {
    echo ${row} | base64 --decode | jq -r ${1}
  }
  id=$(_jq '.id')
  name=$(_jq '.name')
  value=$(bws secret get "$id" --raw)
  # Export to environment
  echo "$name=$value" >> $GITHUB_ENV
  echo "Exported secret: $name"
done