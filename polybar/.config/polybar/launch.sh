#!/bin/bash

## Add this to your wm startup file.
THEME="gruvbox"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get network Interface
DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

# Set up Config file
CONFIG_DIR="$HOME/.config/polybar/themes/$THEME/config.ini"

## Load bar

# Create an env variable in /etc/environment named MACHINE_TYPE, and set it to either "desktop" or "laptop"
echo $MACHINE_TYPE
if [ $MACHINE_TYPE = "desktop" ]; then
		polybar -c $CONFIG_DIR main &

		# Load on second monitor if connected
		external_monitor=$(xrandr --query | grep 'HDMI-0')
		echo "External Monitor: $external_monitor"
		if [[ $external_monitor = HDMI-0\ connected* ]]; then
			polybar -c $CONFIG_DIR secondary &
		fi
    else
		polybar -c $CONFIG_DIR laptop &
fi
