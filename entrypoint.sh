#!/bin/sh
set -e

# Read secrets from the file specified in TS_AUTHFILE into the TS_AUTHKEY
# environment variable. Use TS_AUTHFILE_<HOST> to set the matching
# TS_AUTHKEY<HOST>.
# https://github.com/tailscale/caddy-tailscale#authenticating-to-the-tailcale-network
for secret in $(env | grep "^TS_AUTHFILE"); do
  host="$(echo $secret | sed 's/TS_AUTHFILE_\?\([^=]*\).*/\1/')"
  file="${secret#*=}"

  if [ -z "$host" ]; then
    varname="TS_AUTHKEY"
  else
    varname="TS_AUTHKEY_$host"
  fi

  echo "Reading secret from $file into $varname..."
  export "$varname=$(cat $file | head -n1)"
done

exec "$@"
