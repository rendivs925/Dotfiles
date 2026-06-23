#!/bin/bash
# deadd Notification Sound Daemon
# Uses canberra-gtk-play with XDG sound theme for premium audio.
# Dependencies: libcanberra (provides canberra-gtk-play)

# Sound theme mapping: urgency -> canberra event ID
declare -A SOUNDS
SOUNDS[0]="message"          # low urgency
SOUNDS[1]="dialog-information" # normal urgency
SOUNDS[2]="dialog-warning"    # critical urgency

# Check for canberra-gtk-play
if ! command -v canberra-gtk-play &>/dev/null; then
    echo "deadd-sound-daemon: canberra-gtk-play not found"
    exit 1
fi

echo "deadd-sound-daemon: Running (using canberra-gtk-play)..."

# Monitor DBus for notification signals
dbus-monitor --session "type='method_call',interface='org.freedesktop.Notifications',member='Notify'" 2>/dev/null | \
while read -r line; do
    # Extract urgency byte (0=low, 1=normal, 2=critical)
    if [[ "$line" =~ byte\ ([0-2]) ]]; then
        urgency="${BASH_REMATCH[1]}"
        sound_id="${SOUNDS[$urgency]:-dialog-information}"
        canberra-gtk-play -i "$sound_id" -d "notification" &
    fi
done
