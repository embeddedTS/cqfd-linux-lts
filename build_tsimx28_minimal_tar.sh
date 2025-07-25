#!/bin/bash
set -e

if [ ! -e "/.dockerenv" ]; then
    cqfd -b debianarmel init
    exec cqfd -b debianarmel run "$0 $@"
fi

export EXTERNAL_MODULE_WILC=1

./build-scripts/build-tar.sh tsimx28_minimal_defconfig zImage
