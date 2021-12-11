#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: WireGuard
# Cleans up interfaces 
# ==============================================================================
declare interface

# Get the interface
interface="wg0"
if bashio::config.has_value "server.interface"; then
    interface=$(bashio::config "server.interface")
fi

if ! ip link | grep "${interface}" > /dev/null; then
   bashio::log.info "Interface is already up shutting it down!"
   exec wg-quick down "${interface}"
else
   bashio::log.info "Interface was not up no need to clean up!"
fi
