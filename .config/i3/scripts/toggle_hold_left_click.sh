#!/bin/zsh

DRAW_PID_FILE="/tmp/drawing_pid"
STOP_FLAG="/tmp/stop_drawing"

if [ -f "$DRAW_PID_FILE" ]; then
  echo "Stopping draw..."
  touch "$STOP_FLAG"       
  sleep 0.2                
  rm -f "$DRAW_PID_FILE"   
else
  echo "Starting draw..."
  rm -f "$STOP_FLAG"       
  (
    xdotool mousedown 1
    while true; do
      if [ -f "$STOP_FLAG" ]; then
        break
      fi
      sleep 0.1
    done
    xdotool mouseup 1
  ) &
  echo $! > "$DRAW_PID_FILE"  
fi
