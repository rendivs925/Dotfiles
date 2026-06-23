#!/bin/bash
# ═══════════════════════════════════════════════════════
# deadd-notification-center — Premium Notification Sound
# Plays subtle sounds based on urgency level.
# ═══════════════════════════════════════════════════════
# Usage (as deadd modification script):
#   deadd will pipe notification JSON to this script's stdin.
#   It returns empty modifications (no-op for deadd).
# ═══════════════════════════════════════════════════════

# ── Configuration ──────────────────────────────────
SOUND_DIR="${HOME}/.config/deadd/sounds"
DEFAULT_SOUND="${SOUND_DIR}/default.ogg"
CRITICAL_SOUND="${SOUND_DIR}/critical.ogg"
LOW_SOUND="${SOUND_DIR}/low.ogg"

# Use paplay (PulseAudio) or canberra-gtk-play
if command -v paplay &>/dev/null; then
    PLAYER="paplay"
elif command -v canberra-gtk-play &>/dev/null; then
    PLAYER="canberra-gtk-play --file"
elif command -v aplay &>/dev/null; then
    PLAYER="aplay"
else
    # No audio player found — silently exit
    echo '{"modify": {}, "match": {}}'
    exit 0
fi

play_sound() {
    local file="$1"
    if [[ -f "$file" ]]; then
        $PLAYER "$file" &
    fi
}

# ── Read notification JSON from stdin ─────────────
NOTI_JSON=""
while IFS= read -r line; do
    NOTI_JSON="${NOTI_JSON}${line}"
done

# ── Extract urgency ───────────────────────────────
# Urgency: 0 = low, 1 = normal, 2 = critical
URGENCY=$(echo "$NOTI_JSON" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    hints = data.get('hints', {})
    urgency = hints.get('urgency', 1)
    # 'urgency' can be byte or int
    if isinstance(urgency, bytes):
        urgency = ord(urgency)
    print(int(urgency))
except Exception:
    print(1)
" 2>/dev/null || echo 1)

# ── Play appropriate sound ─────────────────────────
case "$URGENCY" in
    0) play_sound "$LOW_SOUND" ;;
    2) play_sound "$CRITICAL_SOUND" ;;
    *) play_sound "$DEFAULT_SOUND" ;;
esac

# ── Return empty modifications to deadd ────────────
echo '{"modify": {}, "match": {}}'
