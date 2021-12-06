
# My Anycubic Vyper Setup
Currently I use a stock Anycubic Vyper with a Mosaic Manufacturing Palette 2s connected to it.
A DIY Octoprint server was set up to control the two pieces of hardware on a Beelink T4pro mini pc, which has much more horsepower than the aging Pi3b I have that was plagued with undervoltage issues, regardless of power supply used. Also, getting your hands on a new Pi is extremely difficult in 2021 and with the price of the Pi + case + PSU, the Beelink was pretty much the same price and much more powerful. 

I use P2PP in conjunction with PrusaSlicer since I just cannot get the MosaicMFG Canvas cloud app to work properly (their Canvas Hub they shipped was also DOA and seems to have a bad image on the SD card :( ). No matter what I do to set up the printer and canvashub, the tool only provides 1 color to work with, which defeats the whole purpose. 

I personally prefer PrusaSlicer over Cura, so when I stumbled upon P2PP, it was a match made in heaven and makes the gcode generation for the Palette2s and Vyper extremely simple, once configured properly. 


## Octoprint
Setting up Octoprint was a little challenging considering not having a premade image like for the Pi. I originally setup Octoprint and MJPG-streamer using docker + docker-compose, since I use docker for many other things in my home-lab, however, I could not get the canvas & palette plugins for octoprint to work properly (even when passing through the USB device in the docker-compose). If someone else figured this out, please let me know as managing the machine and having all configs in a simple docker-compose file is much easier to manage and redeploy/deploy more printers without needing a bunch of mini PCs everywhere. 

### Initial installation

### Plugins Setup

#### Canvas and Palette Plugins

#### The Spaghetti Detective (offline running locally)

#### Other Noteworthy plugins
TBD

#### Octolapse
TBA - I decided to hold off on this for now as you really need to have things dialed in and configured properly, otherwise you can end up with messy prints, stringing, or a completely failed print
## Prusaslicer

### Main setup

### P2PP integration





> Written with [StackEdit](https://stackedit.io/).
