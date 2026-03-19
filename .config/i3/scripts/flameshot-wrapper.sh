#!/bin/bash
# Wrapper for flameshot to restore i3 workspace assignments after capture

flameshot gui

sleep 0.5

# Restore workspace assignments
i3-msg "workspace 1, output HDMI-1-0"
i3-msg "workspace 2, output HDMI-1-0"
i3-msg "workspace 3, output HDMI-1-0"
i3-msg "workspace 4, output HDMI-1-0"
i3-msg "workspace 5, output HDMI-1-0"
i3-msg "workspace 6, output eDP"
i3-msg "workspace 7, output eDP"
i3-msg "workspace 8, output eDP"
i3-msg "workspace 9, output eDP"
i3-msg "workspace 10, output eDP"
