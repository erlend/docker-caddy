FROM --platform=$BUILDPLATFORM caddy:2.6.4-builder AS build
ARG BUILDPLATFORM

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ENV GOOS="$TARGETOS" GOARCH="$TARGETARCH"
RUN set -x && \
    GOARM="${TARGETVARIANT:1:1}" xcaddy build "$CADDY_VERSION" \
      --with github.com/tailscale/caddy-tailscale
RUN cp /go/pkg/mod/github.com/tailscale/caddy-tailscale@*/Caddyfile /tmp/

FROM caddy
COPY --from=build /tmp/Caddyfile /etc/caddy/Caddyfile
COPY --from=build /usr/bin/caddy /usr/bin/caddy
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
