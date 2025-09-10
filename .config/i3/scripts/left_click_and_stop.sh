#!/bin/bash

# Disable drawing mode if active
rm -f /tmp/drawing_mode

# Get mouse info
eval $(xdotool getmouselocation --shell)

# Find active monitor geometry using xrandr
monitor_info=$(xrandr | grep " connected" | awk '{print $1,$3}')
current_monitor=""
for mon in $monitor_info; do
  if [[ "$mon" == *"+"* ]]; then
    geom=$mon
    mon_name=$current_monitor
    IFS='x+ ' read w h x y <<< "$geom"
    if (( X >= x && X <= x + w && Y >= y && Y <= y + h )); then
      MON_WIDTH=$w
      MON_HEIGHT=$h
      MON_X=$x
      MON_Y=$y
      break
    fi
  else
    current_monitor=$mon
  fi
done

# Calculate center of current monitor
CENTER_X=$((MON_X + MON_WIDTH / 2))
CENTER_Y=$((MON_Y + MON_HEIGHT / 2))

# Move cursor to center and click
xdotool mousemove "$CENTER_X" "$CENTER_Y" click 1
