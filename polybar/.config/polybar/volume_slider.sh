#!/bin/bash

# Get the current volume
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

# Display a slider using zenity
new_volume=$(zenity --scale \
    --title="" \
    --text="Set Volume" \
    --value="$current_volume" \
    --min-value="0" \
    --max-value="100" \
    --step="5" \
    --ok-label="OK" \
    --cancel-label="Cancel" \
    --width=300 \
    --height=100 \
)

# Check if the user clicked OK
if [ $? -eq 0 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ "${new_volume}%"
fi

