#!/bin/bash

# The following command overrides the GTK theming for Flatpaks
sudo flatpak override --filesystem=$HOME/.themes
echo "Flatpaks Theming Overriden"
