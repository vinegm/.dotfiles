#!/bin/bash
CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Are you sure you want to poweroff?")
if [[ $CHOICE == "Yes" ]]; then
    systemctl poweroff
fi

