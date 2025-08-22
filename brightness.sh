#!/usr/bin/env bash
# Usage: brightness.sh up|down|reset|status

STEP=0.10
MIN=0.1
MAX=1.0

# Get the current/primary monitor
OUTPUT=$(xrandr --current | awk '/ connected primary/ {print $1}')

# Fallback if no primary is set, pick first connected monitor
if [ -z "$OUTPUT" ]; then
    OUTPUT=$(xrandr --current | awk '/ connected/ {print $1; exit}')
fi

# Skip if monitor cannot be adjusted
if ! xrandr --verbose | grep -A5 "^$OUTPUT" | grep -q "Brightness"; then
    echo "Monitor $OUTPUT cannot be adjusted."
    exit 1
fi

# Get current brightness
CURRENT=$(xrandr --verbose | grep -A5 "^$OUTPUT" | grep Brightness | awk '{print $2}')

case "$1" in
    up)
        NEW=$(awk -v c="$CURRENT" -v s="$STEP" -v m="$MAX" 'BEGIN{b=c+s; if(b>m) b=m; print b}')
        ;;
    down)
        NEW=$(awk -v c="$CURRENT" -v s="$STEP" -v m="$MIN" 'BEGIN{b=c-s; if(b<m) b=m; print b}')
        ;;
    reset)
        NEW=0.7
        ;;
    status)
        echo "$OUTPUT brightness: $CURRENT"
        exit 0
        ;;
    *)
        echo "Usage: $0 up|down|reset|status"
        exit 1
        ;;
esac

# Apply new brightness
xrandr --output $OUTPUT --brightness $NEW
echo "$OUTPUT brightness set to $NEW"
