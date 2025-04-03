#!/bin/bash

state=$(hyprctl devices | grep -A 4 "Keyboard" | grep "num lock" | awk '{ print $3 }')

if [[ "$state" == "true" ]]; then
    echo '{ "text": "🔢", "tooltip": "Num Lock is ON" }'
else
    echo '{ "text": "❌", "tooltip": "Num Lock is OFF" }'
fi
