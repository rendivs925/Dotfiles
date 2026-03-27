#!/bin/bash

# Small delay to ensure displays are ready (important on startup)
sleep 1

# Detect internal display (prefer primary, fallback to eDP)
INTERNAL=$(xrandr | awk '/ connected primary/ {print $1}')
if [ -z "$INTERNAL" ]; then
    INTERNAL=$(xrandr | awk '/^eDP/ && / connected/ {print $1}')
fi

# Detect external display (any connected display that is not internal)
EXTERNAL=$(xrandr | awk '/ connected/ {print $1}' | grep -v "$INTERNAL" | head -n1)

# Decide target (external if available, otherwise internal)
if [ -n "$EXTERNAL" ]; then
    TARGET="$EXTERNAL"
else
    TARGET="$INTERNAL"
fi

# Move workspaces 1–5 to target (force-create + move)
for i in 1 2 3 4 5; do
    i3-msg "workspace $i; move workspace to output $TARGET" > /dev/null
done

# Move workspaces 6–10 to internal display
for i in 6 7 8 9 10; do
    i3-msg "workspace $i; move workspace to output $INTERNAL" > /dev/null
done

# Focus back to workspace 1
i3-msg "workspace 1" > /dev/null
