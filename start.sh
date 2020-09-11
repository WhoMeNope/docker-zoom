#!/bin/sh

set -ex

xhost local:zoom

if [ "$1" == "-v" ]; then
  docker run --rm -d -e DISPLAY=$DISPLAY --device /dev/video0:/dev/video0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/1000/pulse:/run/pulse zoom
else
  docker run --rm -d -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/1000/pulse:/run/pulse zoom
fi
