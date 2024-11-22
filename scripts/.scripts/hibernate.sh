#!/bin/bash
CHOICE=$(echo -e "No\nYes" | rofi -dmenu -p "Are you sure you want to hibernate?")
if [[ $CHOICE == "Yes" ]]; then
    systemctl hibernate
fi

