#!/bin/bash
# ═══════════════════════════════════════════════════════
# deadd Notification Sound Daemon
# Watches DBus for notification signals and plays sounds.
# ═══════════════════════════════════════════════════════
# Usage:
#   bash ~/.config/deadd/deadd-sound-daemon.sh &
# ═══════════════════════════════════════════════════════

SOUND_DIR="${HOME}/.config/deadd/sounds"
DEFAULT="${SOUND_DIR}/default.ogg"
CRITICAL="${SOUND_DIR}/critical.ogg"
LOW="${SOUND_DIR}/low.ogg"

for p in paplay canberra-gtk-play aplay ffplay; do
    if command -v "$p" &>/dev/null; then
        PLAYER="$p"
        break
    fi
done

if [[ -z "$PLAYER" ]]; then
    echo "deadd-sound-daemon: No audio player found"
    exit 1
fi

play() {
    local file="$1"
    [[ -f "$file" ]] && "$PLAYER" "$file" &>/dev/null &
}

echo "deadd-sound-daemon: Running (player=$PLAYER)..."

dbus-monitor --session "type='method_call',interface='org.freedesktop.Notifications',member='Notify'" 2>/dev/null | \
while read -r line; do
    # Look for urgency byte in the signal
    # urgency: 0=low, 1=normal, 2=critical
    if [[ "$line" =~ byte\ ([0-2]) ]]; then
        urgency="${BASH_REMATCH[1]}"
        case "$urgency" in
            0) play "$LOW"    ;;
            2) play "$CRITICAL" ;;
            *) play "$DEFAULT"  ;;
        esac
    fi
done
