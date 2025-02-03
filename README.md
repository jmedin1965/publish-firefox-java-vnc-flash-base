# remote access image for old servers that do not support HTML5

I have an old CISCO server that has CIMC inbuilt but this card has not had a firmware 
that supports HTML5 supplied by CISCO. Since it is end of life, it will never get this update.

This image is my base image with java, flash and novnc, listening on port 8099, which is the
Home Assistant Ingress port.

I use this image to create the addon in Home Assistant. I used to just run this in Docker, but
since I'm using Home Assistant now, I may as well create it as an addon.

