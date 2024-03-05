#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <client_id> <client_secret>"
    exit 1
fi

client_id=$1
client_secret=$2
auth_credentials=$(echo -n "$client_id:$client_secret" | base64 -w 0)
response=$(curl --silent --fail -X "POST" -H "Authorization: Basic $auth_credentials" -d grant_type=client_credentials https://accounts.spotify.com/api/token)
echo -n "${response}" | jq -r '.access_token'
