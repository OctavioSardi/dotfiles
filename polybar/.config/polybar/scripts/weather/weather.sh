#!/bin/sh

# Run the main.py script and capture its output
weather_info=$(python3 $HOME/polybar-collection/scripts/weather/main.py -u metric)

# Extract temperature and description from the output
temperature=$(echo "$weather_info" | grep -oE '\b[0-9]+ºC\b')
description=$(echo "$weather_info" | grep -oE 'Description: [A-Za-z ]+' | cut -d ' ' -f 2-)

# Output the weather information in the desired format
echo "$temperature, $description"

