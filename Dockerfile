ARG BUILDPLATFORM="linux/amd64"
FROM --platform=$BUILDPLATFORM caddy:2.6.1-builder AS build

ARG TARGETOS="linux"
ARG TARGETARCH="amd64"
ARG TARGETVARIANT
ENV GOOS="linux" GOARCH="$TARGETARCH"
RUN GOARM="${TARGETVARIANT:1:1}" xcaddy build "$CADDY_VERSION" \
      --with github.com/tailscale/caddy-tailscale
RUN cp /go/pkg/mod/github.com/tailscale/caddy-tailscale@*/Caddyfile /tmp/

ARG TARGETPLATFORM="linux/amd64"
FROM --platform=$TARGETPLATFORM caddy
COPY --from=build /tmp/Caddyfile /etc/caddy/Caddyfile
COPY --from=build /usr/bin/caddy /usr/bin/caddy
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
