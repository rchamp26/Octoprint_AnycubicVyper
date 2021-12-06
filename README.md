
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
At least I've been able to make the hardware functional with PrusaSlicer and P2PP. I just don't like Cura and Chroma; they feel much less intuitive and it feels like it was built for PROs who know every aspect of the software already). 

I personally prefer PrusaSlicer over Cura, so when I stumbled upon P2PP, it was a match made in heaven and makes the gcode generation for the Palette2s and Vyper extremely simple, once configured properly. 


## Octoprint
Setting up Octoprint was a little challenging considering not having a premade image like for the Pi. I originally setup Octoprint and MJPG-streamer using docker + docker-compose, since I use docker for many other things in my home-lab, however, I could not get the canvas & palette plugins for octoprint to work properly (even when passing through the USB device in the docker-compose). If someone else figured this out, please let me know as managing the machine and having all configs in a simple docker-compose file is much easier to manage and redeploy/deploy more printers without needing a bunch of mini PCs everywhere. 

### Initial installation
TBD
### Plugins Setup
TBD
#### Canvas and Palette Plugins
TBD
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
TBD

### GCODE Settings

For Turning on and off the LED light

#### Append to your start GCODE

    M355 S1; led on 

#### Append to your end GCODE

    M355 S0; led off


> Written with [StackEdit](https://stackedit.io/).
