#!/bin/bash
#-------------------------------------------------
# fix autofocus and exposure
# to run this script at boot with crontab -e since these manual settings only seem to persist between reboots
# These settings work well for me. If you reposition or change lighting, you will want to adjust your settings here
#------------------------------------------------
v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=0
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=1
v4l2-ctl -d /dev/video0 --set-ctrl=focus_absolute=270
v4l2-ctl -d /dev/video0 --set-ctrl=saturation=70
v4l2-ctl -d /dev/video0 --set-ctrl=brightness=-10
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_absolute=150
v4l2-ctl -d /dev/video0 --set-ctrl=backlight_compensation=2
