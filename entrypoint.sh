#!/bin/sh
set -e

# Read secrets from the file specified in TS_SECRETNAME into the TS_AUTHKEY
# environment variable. Use TS_SECRETNAME_<HOST> to set the matching
# TS_AUTHKEY<HOST>.
# https://github.com/tailscale/caddy-tailscale#authenticating-to-the-tailcale-network
for secret in $(env | grep "^TS_SECRETNAME"); do
  host="$(echo $secret | sed 's/TS_SECRETNAME_\?\([^=]*\).*/\1/')"
  secret_file="/run/secrets/${secret#*=}"

  if [ -z "$host" ]; then
    varname="TS_AUTHKEY"
  else
    varname="TS_AUTHKEY_$host"
  fi

  echo "Reading secret from $secret_file into $varname..."
  export "$varname=$(cat $secret_file | head -n1)"
done

exec "$@"
