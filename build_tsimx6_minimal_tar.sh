#!/bin/bash
set -euo pipefail

if [ ! -e "/.dockerenv" ]; then
    cqfd -b debianarmhf init
    exec cqfd -b debianarmhf run "$0 $@"
fi

export LOADADDR=0x10008000
export EXTERNAL_MODULE_WILC=1

./build-scripts/build-tar.sh tsimx6_minimal_defconfig uImage
