#!/usr/bin/env bash

# Kill existing polybar instances
killall -q polybar

# Wait until they are all closed
while pgrep -u "$UID" -x polybar >/dev/null; do
  sleep 1
done

# Launch polybar on each monitor
while read -r monitor; do
  MONITOR=${monitor%%:*} polybar main &
done < <(polybar --list-monitors)

wait
