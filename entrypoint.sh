#!/bin/sh

# Ensure data directory exists for persistent storage
mkdir -p /data/auth

# Generate config.yaml in /data (persistent volume) if it doesn't exist
if [ ! -f /data/config.yaml ]; then
cat > /data/config.yaml <<EOF
host: ""
port: ${PORT:-8317}

remote-management:
  allow-remote: true
  secret-key: "${MANAGEMENT_PASSWORD:-}"
  disable-control-panel: false
  panel-github-repository: "https://github.com/router-for-me/Cli-Proxy-API-Management-Center"

auth-dir: "/data/auth"

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
else
echo "Using existing config.yaml from volume"
fi

exec ./CLIProxyAPI -config /data/config.yaml
