#!/bin/bash

current_sink=$(pactl info | grep "Default Sink" | cut -d' ' -f3)

sinks=($(pactl list short sinks | cut -f2))

for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" = "$current_sink" ]]; then
        index=$i
        break
    fi
done

next_index=$(( (index + 1) % ${#sinks[@]} ))

pactl set-default-sink "${sinks[$next_index]}"

for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "${sinks[$next_index]}"
done

