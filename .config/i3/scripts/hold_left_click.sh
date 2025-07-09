#!/bin/zsh

xdotool mousedown 1

touch /tmp/drawing_mode

while true; do
  if [ ! -f /tmp/drawing_mode ]; then
    break
  fi
  sleep 0.1
done

xdotool mouseup 1
