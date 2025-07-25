#!/bin/bash
set -e

if [ ! -e "/.dockerenv" ]; then
    cqfd -b debianarmhf init
    exec cqfd -b debianarmhf run "$0 $@"
fi

./build-scripts/build-tar.sh tsa38x_minimal_defconfig zImage
