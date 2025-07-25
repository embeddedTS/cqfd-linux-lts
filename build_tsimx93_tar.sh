#!/bin/bash
set -e

if [ ! -e "/.dockerenv" ]; then
    cqfd -b debianarm64 init
    exec cqfd -b debianarm64 run "$0 $@"
fi

./build-scripts/build-tar.sh ts9370_defconfig Image
