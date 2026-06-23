#!/bin/bash
# deadd-notification-center - Launch Script
# Starts deadd on all monitors + notification sound daemon.

# Terminate existing instances
pkill -f deadd-notification-center
pkill -f deadd-sound-daemon

sleep 0.5

# Determine monitor count
MONITORS=$(xrandr --query | grep " connected" | grep -v " disconnected" | wc -l)

# Launch deadd per monitor
for i in $(seq 0 $((MONITORS - 1))); do
    monitor=$(xrandr --query | grep " connected" | grep -v " disconnected" | sed -n $((i + 1))p | awk '{print $1}')
    sed "s/monitor: .*/monitor: $i/" ~/.config/deadd/deadd.yml > /tmp/deadd-$i.yml
    deadd-notification-center -c /tmp/deadd-$i.yml &
    echo "deadd: launched on $monitor (index $i)"
done

# Sound daemon
bash ~/.config/deadd/deadd-sound-daemon.sh &
echo "deadd: sound daemon started"

echo "deadd: ready on $MONITORS monitor(s)"
