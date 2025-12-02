#!/bin/bash

pkill waybar

hyprctl reload
hyprctl dispatch exec waybar &
