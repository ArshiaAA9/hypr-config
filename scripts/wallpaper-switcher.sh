#!/bin/bash

read -r input_file
echo $input_file

# Check if input is empty (user pressed Esc in rofi)
if [ -z "$input_file" ]; then
    exit 0
fi

# Verify the file exists
if [ ! -f "/home/arshia/wallpapers/$input_file" ]; then
    echo "Error: File not found: /home/arshia/wallpapers/$input_file" >&2
    exit 1
fi

hyprctl hyprpaper wallpaper , "/home/arshia/wallpapers/$input_file"
