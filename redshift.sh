#!/usr/bin/bash


sudo apt install redshift-gtk

echo "
[Desktop Entry]
Version=1.0
Name=Redshift
Exec=redshift-gtk -l 25.2:49.6 -t 4300:4300 -g 0.8 -m randr -v
Icon=redshift
Terminal=false
Type=Application
Categories=Utility;
StartupNotify=true
Hidden=false
X-GNOME-Autostart-enabled=true
NoDisplay=false
" > ~/.config/autostart/file.txt
