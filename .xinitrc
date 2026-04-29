#!/bin/sh
# Start dbus if not already running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
fi
export DBUS_SESSION_BUS_ADDRESS

# Set XDG variables
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP=i3
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME/Downloads
export XDG_DOCUMENTS_DIR=$HOME/Documents
export XDG_PICTURES_DIR=$HOME/Pictures

# Make sure user services see the same X11 session
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS

exec i3
