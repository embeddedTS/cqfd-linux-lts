# syntax = docker/dockerfile:1.2

FROM debian:bookworm

# Install host tools
RUN apt-get update && apt-get install -y \
    bc \
    bison \
    build-essential \
    flex \
    git \
    kmod \
    libncurses-dev \
    libssl-dev \
    lzop \
    make \
    pkgconf \
    rsync \
    sudo \
    u-boot-tools \
    zstd

# Install arch specific packages:
RUN dpkg --add-architecture armhf && apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabihf \
    libc6-dev:armhf \
    libgpiod-dev:armhf

ENV CROSS_COMPILE=arm-linux-gnueabihf-
ENV ARCH=arm
