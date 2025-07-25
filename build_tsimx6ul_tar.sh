#!/bin/bash
set -e

if [ ! -e "/.dockerenv" ]; then
    cqfd -b debianarmhf init
    exec cqfd -b debianarmhf run "$0 $@"
fi

export EXTERNAL_MODULE_WILC=1

./build-scripts/build-tar.sh tsimx6ul_defconfig zImage
