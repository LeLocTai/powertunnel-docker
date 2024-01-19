#!/bin/bash

POWER_TUNNEL_ARGS="-disable-updater -start"

if [ -n "$IP" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -ip $IP"
fi

if [ -n "$PORT" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -port $PORT"
fi

if [ -n "$AUTH_USERNAME" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -auth-username $AUTH_USERNAME"
fi

if [ -n "$AUTH_PASSWORD" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -auth-password $AUTH_PASSWORD"
fi

if [ -n "$UPSTREAM_PROXY_HOST" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -upstream-proxy-host $UPSTREAM_PROXY_HOST"
fi

if [ -n "$UPSTREAM_PROXY_PORT" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -upstream-proxy-port $UPSTREAM_PROXY_PORT"
fi

if [ -n "$UPSTREAM_PROXY_PROTOCOL" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -upstream-proxy-protocol $UPSTREAM_PROXY_PROTOCOL"
fi

if [ -n "$UPSTREAM_AUTH_USERNAME" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -upstream-auth-username $UPSTREAM_AUTH_USERNAME"
fi

if [ -n "$UPSTREAM_AUTH_PASSWORD" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -upstream-auth-password $UPSTREAM_AUTH_PASSWORD"
fi

if [ -n "$ENABLE_LOGGING" ]; then
  POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -enable-logging"
fi

# Handle multiple -cfg arguments
if [ -n "$CFG" ]; then
  IFS=',' read -ra CFG_VALUES <<< "$CFG"
  for value in "${CFG_VALUES[@]}"; do
    POWER_TUNNEL_ARGS="$POWER_TUNNEL_ARGS -cfg $value"
  done
fi

# Link configuration files
cd /opt
ln -sf /config/* /opt

# Execute the PowerTunnel JAR with the configured arguments
exec java -jar PowerTunnel.jar $POWER_TUNNEL_ARGS
