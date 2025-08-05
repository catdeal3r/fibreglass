#!/bin/sh

isMounted=$(findmnt -S /dev/sda1)
if [[ $? == 1 ]]; then
  udisksctl mount -b /dev/sda1
fi
