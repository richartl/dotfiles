#!/bin/sh
# This scrips must be in /usr/lib/systemd/system-sleep
# This script is for alienware because the wifi is not work after suspend
if [ "${1}" == "post" ]; then
  echo 1 | sudo tee /sys/bus/pci/rescan
fi
