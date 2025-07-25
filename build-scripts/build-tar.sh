#!/bin/bash -e

DEFCONFIG="$1"
TARGET="$2"

if [ ! -d linux ]; then
	echo "Clone your linux source tree to linux/ to build:"
	echo "git clone https://github.com/embeddedTS/linux-lts.git linux"
	exit 1
fi

if [ "$EXTERNAL_MODULE_WILC" == "1" ] && [ ! -d wilc3000-external-module ]; then
	echo "Clone the external wilc module to build:"
	echo "git clone -b linux4microchip-2024.04 https://github.com/embeddedTS/wilc3000-external-module/"
	exit 1
fi

cd linux
make "$DEFCONFIG"
make -j$(nproc)
make -j$(nproc) "$TARGET"

TEMPDIR=$(mktemp -d)
mkdir "${TEMPDIR}/boot/"
cp arch/${ARCH}/boot/${TARGET} "${TEMPDIR}/boot"
find arch/${ARCH}/boot/dts -regextype posix-extended -regex '.*/*ts[0-9]{4}.*\.dtb.*' -exec cp {} "${TEMPDIR}/boot" \;
INSTALL_MOD_PATH="${TEMPDIR}" make modules_install
make headers_install INSTALL_HDR_PATH="${TEMPDIR}" # Optional
cp .config "${TEMPDIR}"/boot/config # Optional

if [ "${EXTERNAL_MODULE_WILC}" == "1" ]; then
    CONFIG_WILC_SPI=m INSTALL_MOD_PATH="${TEMPDIR}" make M=../wilc3000-external-module modules modules_install
fi

TAR_NAME=linux-${DEFCONFIG%_defconfig}-"$(date +"%Y%m%d")"-"$(git describe --abbrev=8 --dirty --always)".tar.gz

fakeroot sh -c "chmod 755 ${TEMPDIR};
        chown -R root:root ${TEMPDIR};
        tar czf $TAR_NAME -C ${TEMPDIR} .";

rm -rf "${TEMPDIR}"

echo "Tar is ready at $(realpath $TAR_NAME)"
