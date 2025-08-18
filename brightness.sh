#!/usr/bin/env bash
# Usage: brightness.sh up|down|reset|status

STEP=0.10
MIN=0.1
MAX=1.0

for OUTPUT in $(xrandr --current | awk '/ connected/ {print $1}'); do
    # Skip outputs without a gamma-capable CRTC
    if ! xrandr --verbose | grep -A5 "^$OUTPUT" | grep -q "Brightness"; then
        continue
    fi

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
            continue
            ;;
        *)
            echo "Usage: $0 up|down|reset|status"
            exit 1
            ;;
    esac

    # Apply new brightness
    xrandr --output $OUTPUT --brightness $NEW
    # Print status
    echo "$OUTPUT brightness set to $NEW"
done
