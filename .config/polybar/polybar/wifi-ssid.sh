#!/bin/bash

ssid=$(nmcli -t -f ACTIVE,SSID device wifi | grep "^yes" | cut -d: -f2)

if [ -n "$ssid" ]; then
    echo "%{F#47FF9C}wifi%{F-} $ssid"
else
    echo ""
fi
