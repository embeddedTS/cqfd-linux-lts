# Linux‑LTS Kernel Builder with cqfd

This repository provides a **reproducible kernel cross‑compilation environment** for EmbeddedTS boards using **[cqfd](https://github.com/savoirfairelinux/cqfd)**. It supports building kernels using project-specific Docker containers.

---

# Quick Start

## Install Dependencies

```bash
## Install Docker
## Debian/Ubuntu
#sudo apt-get update && sudo apt-get install docker.io -y

## Redhat
#sudo dnf install -y dnf-plugins-core
#sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#sudo dnf install -y docker-ce docker-ce-cli containerd.io
#sudo systemctl enable --now docker

# Test with:
docker run hello-world

## Install CQFD
git clone https://github.com/savoirfairelinux/cqfd
cd cqfd
make install
```

## Build a Kernel (e.g. `tsimx6ul`)

```bash

# Clone the linux kernel:
git clone git clone https://github.com/embeddedTS/linux-lts.git linux -b linux-6.6.y

# Clone the wilc3000 external module (used also on tsimx6/tsimx28 targets, not needed for others)
git clone -b linux4microchip-2024.04 https://github.com/embeddedTS/wilc3000-external-module/"

# Run the build script (host side)
./build_tsimx6ul.sh
```

This will:

* Automatically initialize the `cqfd` container on first run or when modified
* Launch the build inside the Debian container with the Debian armhf cross toolchain
* Call `build-scripts/build-tar.sh` with the correct defconfig and image type

The resulting tarball will appear in the linux/ directory.

## Customize Kernel Config

To customize kernel options via `menuconfig`:

```bash
cqfd -b debianarmhf shell
make tsimx6ul_defconfig
make menuconfig
make savedefconfig
cp defconfig arch/arm/configs/tsimx6ul_defconfig
```

Save changes, then exit the container. Use the `build_tsimx6ul.sh` script again to generate the new image and tarball.

---

# Supported Targets
| Script Name                   | CQFD Flavor  | Kernel Source                                                                    |
|-------------------------------|--------------|----------------------------------------------------------------------------------|
| build_tsa38x_minimal_tar.sh   | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsa38x_tar.sh           | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx28_minimal_tar.sh  | debianarmel  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx28_tar.sh          | debianarmel  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx6_minimal_tar.sh   | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx6_tar.sh           | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx6ul_minimal_tar.sh | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx6ul_tar.sh         | debianarmhf  | [linux-lts](https://github.com/embeddedts/linux-lts/)                            |
| build_tsimx93_tar.sh          | debianarm64  | [prototype-linux-imx93](https://github.com/embeddedTS/prototype-linux-imx93.git) |

---

# References

* [cqfd documentation](https://github.com/savoirfairelinux/cqfd#readme)
* [linux-lts](https://github.com/embeddedts/linux-lts/)
* [prototype-linux-imx93](https://github.com/embeddedTS/prototype-linux-imx93.git)

Licensed under MIT
