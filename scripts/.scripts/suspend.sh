#!/bin/bash
CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Are you sure you want to suspend?")
if [[ $CHOICE == "Yes" ]]; then
    systemctl suspend
fi

