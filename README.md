
# My Anycubic Vyper Setup

## The Build
### Hardware
- [Anycubic Vyper](https://www.anycubic.com/products/anycubic-vyper)
- [Mosaic Palette 2s](https://www.mosaicmfg.com/products/palette-2s)
- [Beelink T4 Pro](https://www.amazon.com/Beelink-Windows-Celeron-Computer-Supports/dp/B09373HTN7/ref=sr_1_3?keywords=beelink%20t4%20pro&qid=1638812712&s=electronics&sr=1-3) mini PC (for running Octoprint)
- [NexiGo N660p](https://www.amazon.com/AutoFocus-Microphone-NexiGo-N660P-Computer/dp/B08L7ZLNHB) webcam for timelapse and remote monitoring of prints
- Old extra PC running The Spaghetti Detective (to limit CPU consumption on the Octoprint server. I may move this to the Beelink as so far the CPU and memory have barely been touched)

### Software
- OS - Debian 11
	- v4l2 (for tweaking and controlling the webcam settings better)
	- docker + docker-compose (I still use docker for the mjpg-streaming for the webcam)
- Octoprint
	- [Mosaic plugins](https://support.mosaicmfg.com/Guide/Setup+Guide:+DIY+CANVAS+Hub+(OctoPi+++CANVAS+and+P2+Plugins)/42)
		- [Canvas Plugin](https://gitlab.com/mosaic-mfg/canvas-plugin/-/archive/master/canvas-plugin-master.zip) 
		- [Palette 2 Plugin](https://gitlab.com/mosaic-mfg/palette-2-plugin/-/archive/master/palette-2-plugin-master.zip)
	- [The Spaghetti Detective](https://github.com/TheSpaghettiDetective/TheSpaghettiDetective) - amazing tool for monitoring your prints and stopping them, if a failure is detected. Fully Opensource and you can run in locally if you're technical, otherwise i recommend using their cloud service. it's very reasonably priced (free for light use and inexpensive for heavy use)

- [PrusaSlicer](https://www.prusa3d.com/page/prusaslicer_424/) for Slicing models on my laptop. Amazing tool! I'm waiting for the new XL to be released and will probably invest in one once the early kinks are ironed out
-  [P2PP](https://github.com/tomvandeneede/p2pp) - Palette 2 Post Processing Tool for PrusaSlicer/Slic3r PE
	

Currently I use a stock Anycubic Vyper with a Mosaic Manufacturing Palette 2s connected to it.

A DIY Octoprint server was set up to control the two pieces of hardware on a Beelink T4pro mini pc, which has much more horsepower than the aging Pi3b I have that was plagued with undervoltage issues, regardless of power supply/cabes used. Also, getting your hands on a new Pi is extremely difficult in 2021 and with the price of the Pi + case + PSU, the Beelink was pretty much the same price and much more powerful/flexible being amd64 based instead of ARM based. 

I use P2PP in conjunction with PrusaSlicer since I just cannot get the MosaicMFG Canvas cloud app to work properly. No matter what I do to set up the printer and canvashub, the tool only provides 1 color to work with, which defeats the whole purpose of it.  (their Canvas Hub they shipped was also DOA and seems to have a bad image on the SD card :(. Still waiting on response from support on both issues. Will post a resolution if I ever get one.)
At least I've been able to make the hardware functional with PrusaSlicer and P2PP. I just don't like Cura and Chroma; they feel much less intuitive (to me at least) and it feels like it was built for Pros who know every aspect of the software already). Prusaslicer was much more user friendly to me when I first got started with slicing for the Vyper.

I personally prefer PrusaSlicer over Cura, so when I stumbled upon P2PP, it was a match made in heaven and makes the gcode generation for the Palette2s and Vyper extremely simple, once configured properly. When you only want to print a single color, just select your single color profiles. Phyisally, I just load up a spool on the stock holder and print. When wanting to multi-color print, switch to the Palette2 Profiles you create, and boom when you hit slice, after Prusaslicer is done with its part, it sends it to p2pp to do its Palette gcode magic. 


## Octoprint
Setting up Octoprint was a little challenging considering not having a premade image like for the Pi. I originally setup Octoprint and MJPG-streamer using docker + docker-compose, since I use docker for many other things in my home-lab, however, I could not get the canvas & palette plugins for octoprint to work properly (even when passing through the USB device in the docker-compose). If someone else figured this out, please let me know as managing the machine and having all configs in a simple docker-compose file is much easier to manage and redeploy/deploy more printers without needing a bunch of mini PCs everywhere. 

### Initial installation
1. Clean Debian install ( I used Debian 11 (Bullseye) ) create a user "octoprint"
2. Install prereqs for Octoprint
	`sudo apt update`
	`sudo apt upgrade`
    ```sudo apt install python3 python3-dev python-pip git virtualenv```
3. Navigate to where you want to install octoprint (i.e. /home/octoprint/) then create a virtual environment to install octoprint into
`virtualenv venv`
Then I used `pip` to install Octoprint
`./venv/bin/pip install octoprint`

[other reference material](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337)

### Webcam setup
I used a NexiGo N660p camera. Pretty much plug and play. You can find out what it is connected as by using the command `ls /dev/v*` first before plugging in and then again after. You should see the camera show up as `/dev/video0` if you have no other video capable USB devices plugged in. The N660p showed up as two devices (video0 and video1). In this case we'll just use `/dev/video0`. Installing `v4l2` program allowed to disable autofocus and tweak camera settings for better performance. 
`sudo apt install v4l-utils`
help and controls can be found by typing `v4l2-ctl --help`
to see what features/controls v4l2 can do for your camera use:
`v4l2-ctl -d /dev/video0 --list-ctrls`
You should see something like this.
```

                     brightness 0x00980900 (int)    : min=-64 max=64 step=1 default=0 value=-10
                       contrast 0x00980901 (int)    : min=0 max=100 step=1 default=34 value=34
                     saturation 0x00980902 (int)    : min=0 max=128 step=1 default=50 value=70
                            hue 0x00980903 (int)    : min=-180 max=180 step=1 default=0 value=0
 white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
                          gamma 0x00980910 (int)    : min=100 max=500 step=1 default=300 value=300
                           gain 0x00980913 (int)    : min=0 max=128 step=1 default=64 value=64
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=1 value=1
      white_balance_temperature 0x0098091a (int)    : min=2800 max=6500 step=10 default=4600 value=4600 flags=inactive
                      sharpness 0x0098091b (int)    : min=0 max=100 step=1 default=40 value=40
         backlight_compensation 0x0098091c (int)    : min=0 max=2 step=1 default=0 value=2
                  exposure_auto 0x009a0901 (menu)   : min=0 max=3 default=3 value=1
              exposure_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=150
         exposure_auto_priority 0x009a0903 (bool)   : default=0 value=1
                   pan_absolute 0x009a0908 (int)    : min=-57600 max=57600 step=3600 default=0 value=0
                  tilt_absolute 0x009a0909 (int)    : min=-43200 max=43200 step=3600 default=0 value=0
                 focus_absolute 0x009a090a (int)    : min=0 max=1023 step=1 default=0 value=270
                     focus_auto 0x009a090c (bool)   : default=1 value=0
                  zoom_absolute 0x009a090d (int)    : min=0 max=3 step=1 default=0 value=0

```
To disable auto-focus, you can use the `--set-ctrl=` flag
`v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=0`
 
I created a [fixcam.sh](https://github.com/rchamp26/Octoprint_AnycubicVyper/blob/main/fixcam.sh) bash file that I input all of the tweaks. 	
Using `crontab -e` append following line
`@reboot bash /home/octoprint/fixcam.sh`

### Plugins Setup
TBD
#### Canvas and Palette Plugins
Info on how to setup your octoprint server with Canvas and Palette plugins [here](https://support.mosaicmfg.com/Guide/Setup+Guide:+DIY+CANVAS+Hub+(OctoPi+++CANVAS+and+P2+Plugins)/42)


#### The Spaghetti Detective (offline running locally)
TBD
#### Other Noteworthy plugins
TBD

#### Octolapse
TBA - I decided to hold off on this for now as you really need to have things dialed in and configured properly, otherwise you can end up with messy prints, stringing, or a completely failed print


## Prusaslicer

### Main setup
TBD
### P2PP integration
[P2PP](https://github.com/tomvandeneede/p2pp)
Manual for setting up P2PP for the Palette2 is here [https://github.com/tomvandeneede/p2pp/blob/master/docs/P2PP%20user%20manual.pdf](https://github.com/tomvandeneede/p2pp/blob/master/docs/P2PP%20user%20manual.pdf)


### GCODE Settings

For Turning on and off the LED light

#### Append to your start custom GCODE

    M355 S1; led on 

#### Append to your end custom GCODE

    M355 S0; led off


![Supports amd64 Architecture][op-vyper-amd64-shield]


[op-vyper-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg?style=flat
