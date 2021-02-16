#!/bin/sh

set -ex

xhost local:zoom

DEVICE=""
if [ "$1" == "-v" ]; then
  DEVICE+="--device /dev/video0:/dev/video0"
fi

docker run --rm -d -e DISPLAY=$DISPLAY $DEVICE -v $(pwd)/.zoom:/home/developer/.zoom -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/1000/pulse:/run/pulse zoom
