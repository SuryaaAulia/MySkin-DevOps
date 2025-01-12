#!/bin/sh

if [ -z "$CUSTOM_PROXY_PASS" ]; then
    echo "Error: CUSTOM_PROXY_PASS environment variable is not set."
    exit 1
fi

envsubst '${CUSTOM_PROXY_PASS}' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf

echo "Generated /etc/nginx/nginx.conf:"
cat /etc/nginx/nginx.conf

