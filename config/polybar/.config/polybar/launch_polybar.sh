#!/usr/bin/env bash

# Terminate already running bar instances:
polybar-msg cmd quit
# Nuclear option:
# killall -q polybar

polybar main_monitor &

if [[ $(xrandr -q | grep "HDMI-0 connected") ]]; then
  polybar external_monitor &
fi

