#!/bin/sh

# Generate config.yaml from environment variables if it doesn't exist
if [ ! -f /CLIProxyAPI/config.yaml ]; then
cat > /CLIProxyAPI/config.yaml <<EOF
host: ""
port: ${PORT:-8317}

remote-management:
  allow-remote: true
  secret-key: "${MANAGEMENT_PASSWORD:-}"
  disable-control-panel: false
  panel-github-repository: "https://github.com/router-for-me/Cli-Proxy-API-Management-Center"

auth-dir: "~/.cli-proxy-api"

api-keys:
  - "${API_KEY:-your-api-key}"

debug: false

usage-statistics-enabled: ${USAGE_STATS:-false}

proxy-url: ""
request-retry: 3
max-retry-credentials: 0
max-retry-interval: 30
EOF
echo "Generated config.yaml from environment variables"
fi

exec ./CLIProxyAPI
