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
RUN dpkg --add-architecture arm64 && apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu \
    libc6-dev:arm64 \
    libgpiod-dev:arm64

ENV CROSS_COMPILE=aarch64-linux-gnu-
ENV ARCH=arm64
