#!/bin/bash

# Script to dynamically set workspace outputs based on connected displays
# If HDMI-1-0 is connected, workspaces 1-5 go there; otherwise they go to eDP

# Check if HDMI-1-0 is connected
if xrandr | grep "HDMI-1-0 connected" > /dev/null 2>&1; then
    TARGET="HDMI-1-0"
else
    TARGET="eDP"
fi

# Set workspaces 1-5 to the target output (HDMI if available, else eDP)
for i in 1 2 3 4 5; do
    i3-msg "workspace $i output $TARGET"
done

# Workspaces 6-10 always stay on eDP
for i in 6 7 8 9 10; do
    i3-msg "workspace $i output eDP"
done

# Focus on workspace 1 initially
i3-msg "workspace 1"
