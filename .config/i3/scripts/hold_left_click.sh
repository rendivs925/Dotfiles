#!/bin/zsh

# Start holding the left mouse button (mousedown = press and hold)
xdotool mousedown 1

# Infinite loop to keep holding
while true; do
  if [ -f /tmp/stop_drawing ]; then
    break
  fi
  sleep 0.1
done

# Release the mouse button once the loop is stopped
xdotool mouseup 1
