#!/usr/bin/env bash

# Terminate already running bar instances:
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
polybar bar 2>&1 | tee -a /tmp/polybar1.log & disown

