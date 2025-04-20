#!/usr/bin/env bash
set -euo pipefail

# Escape the input for JSON
ESCAPED_CONTENT=$(echo "$1" | jq -Rs .)

# Create the full request body
REQUEST_BODY=$(cat <<END
{
  "model": "claude-3-7-sonnet-20250219",
  "max_tokens": 4096,
  "temperature": 0.2,
  "system": "You are a senior DevOps engineer who writes Terraform docs and tests.",
  "messages": [{"role":"user","content":${ESCAPED_CONTENT}}]
}
END
)

# Print the request body for debugging (optional)
echo "Request body:" >&2
echo "$REQUEST_BODY" | jq . >&2

# Make the API call
curl -s https://api.anthropic.com/v1/messages \
  -H "x-api-key:$ANTHROPIC_API_KEY" \
  -H 'anthropic-version: 2023-06-01' \
  -H 'content-type: application/json' \
  -d "$REQUEST_BODY"
