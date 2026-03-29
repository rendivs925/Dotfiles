#!/bin/bash

# Terminate already running deadd instances
pkill -f deadd-notification-center

# Wait a moment
sleep 1

# Get monitor indices
MONITORS=$(xrandr --query | grep "connected" | grep -v "disconnected" | wc -l)

# Launch deadd on each monitor
for i in $(seq 0 $((MONITORS - 1))); do
    monitor=$(xrandr --query | grep "connected" | grep -v "disconnected" | sed -n $((i + 1))p | awk '{print $1}')
    
    # Create monitor-specific config
    sed "s/monitor: .*/monitor: $i/" ~/.config/deadd/deadd.yml > /tmp/deadd-$i.yml
    
    deadd-notification-center -c /tmp/deadd-$i.yml &
    echo "Deadd launched on $monitor (index $i)"
done

echo "Deadd notification center launched on all $MONITORS monitors"
