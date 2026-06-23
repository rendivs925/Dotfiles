#!/usr/bin/env python3
"""
deadd Notification Sound Daemon
Monitors DBus for notifications and plays premium sounds.
"""

import dbus
import dbus.mainloop.glib
import subprocess
import os
from gi.repository import GLib

SOUND_DIR = os.path.expanduser("~/.config/deadd/sounds")
SOUNDS = {
    0: os.path.join(SOUND_DIR, "low.ogg"),
    1: os.path.join(SOUND_DIR, "default.ogg"),
    2: os.path.join(SOUND_DIR, "critical.ogg"),
}

# Find audio player
for player in ["paplay", "canberra-gtk-play", "aplay", "ffplay"]:
    path = subprocess.run(["which", player], capture_output=True, text=True).stdout.strip()
    if path:
        AUDIO_PLAYER = path
        break
else:
    AUDIO_PLAYER = None


def play_sound(filepath: str):
    if not os.path.isfile(filepath) or AUDIO_PLAYER is None:
        return
    subprocess.Popen(
        [AUDIO_PLAYER, filepath],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def on_notification(bus, message):
    if message.get_member() != "Notify":
        return

    urgency = 1  # default normal
    try:
        args = message.get_args_list()
        if len(args) >= 8:
            hints = args[6]
            if isinstance(hints, dict) and "urgency" in hints:
                urgency = int(hints["urgency"])
    except Exception:
        pass

    play_sound(SOUNDS.get(urgency, SOUNDS[1]))


def main():
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

    bus = dbus.SessionBus()
    bus.add_match_string(
        "interface='org.freedesktop.Notifications',member='Notify'"
    )
    bus.add_message_filter(on_notification)

    print("deadd-sound-daemon: Running...")
    loop = GLib.MainLoop()
    try:
        loop.run()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
