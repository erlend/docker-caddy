# Caddy with Tailscale plugin

[![Docker Build](https://github.com/erlend/docker-caddy/actions/workflows/docker.yml/badge.svg)](https://github.com/erlend/docker-caddy/actions/workflows/docker.yml)
![Docker Image Version](https://img.shields.io/docker/v/erlend/caddy/latest)
![Docker Image Size](https://img.shields.io/docker/image-size/erlend/caddy/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/erlend/caddy)
![Docker Stars](https://img.shields.io/docker/stars/erlend/caddy)

The latest [caddy](http://hub.docker.com/_/caddy) with the *experimental*
[Tailscale Caddy plugin](https://github.com/tailscale/caddy-tailscale)

## Configuration

Set one of the following environment variables to authenticate with Tailscale.
The "Auth key" can be created on the
[Keys Settings page](https://login.tailscale.com/admin/settings/keys)
if you haven't done so already.

| Name          | Description                                         |
| ------------- | --------------------------------------------------- |
| `TS_AUTHKEY`  | Tailscale Auth key                                  |
| `TS_AUTHFILE` | Read authkey from this file instead of `TS_AUTHKEY` |

Alternately `TS_AUTHKEY_<NODE>` or `TS_AUTHFILE_<NODE>` as [described here](https://github.com/tailscale/caddy-tailscale#authenticating-to-the-tailcale-network).

You can see a [working example here](https://github.com/erlend/caddy-tailscale-example).
