#!/bin/bash
opt="$1"

if [ -z "$opt" ]; then
  rofi -show drun
  exit 0
fi

if [ "$opt" = "power" ]; then
  rofi -show power -theme power -location 3 -xoffset -15 -yoffset 50
elif [ "$opt" = "drun" ]; then
  rofi -show drun
elif [ -z "$opt" ]; then
  notify-send "Rofi lauch option unrecognized!"
fi

