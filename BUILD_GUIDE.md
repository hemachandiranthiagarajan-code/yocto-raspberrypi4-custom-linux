# Building a Custom Embedded Linux for Raspberry Pi 4 Using Yocto

## Introduction

This guide explains how to build a custom Embedded Linux distribution for Raspberry Pi 4 using the Yocto Project (Kirkstone).

## Prerequisites

Recommended:

```text
Ubuntu 22.04 LTS
RAM: 16 GB
Storage: 100+ GB
```

## Install Required Packages

```bash
sudo apt update
sudo apt install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint xterm zstd liblz4-tool file locales
```

## Create Workspace

```bash
mkdir -p ~/yocto-rpi
cd ~/yocto-rpi
```

## Clone Sources

```bash
git clone -b kirkstone git://git.yoctoproject.org/poky
git clone -b kirkstone https://github.com/agherzan/meta-raspberrypi.git
git clone -b kirkstone https://github.com/openembedded/meta-openembedded.git
```

## Initialize Build Environment

```bash
cd poky
source oe-init-build-env build-rpi
```

## Add Layers

```bash
bitbake-layers add-layer ../../meta-raspberrypi
bitbake-layers add-layer ../../meta-openembedded/meta-oe
bitbake-layers add-layer ../../meta-openembedded/meta-networking
```

## Configure Raspberry Pi 4

Edit `conf/local.conf`:

```conf
MACHINE = "raspberrypi4-64"
EXTRA_IMAGE_FEATURES += "ssh-server-openssh"
DISTRO_FEATURES:append = " wifi"
ENABLE_I2C = "1"
ENABLE_SPI_BUS = "1"
```

## Create Custom Layer

```bash
bitbake-layers create-layer ../../meta-rpiwifi
bitbake-layers add-layer ../../meta-rpiwifi
```

## Wi-Fi Configuration

Create `wpa_supplicant.conf`:

```conf
ctrl_interface=/var/run/wpa_supplicant
network={
    ssid="YOUR_WIFI_SSID"
    psk="YOUR_WIFI_PASSWORD"
}
```

## Build

```bash
bitbake core-image-base
```

## Flash

```bash
sudo bmaptool copy core-image-base.wic.bz2 /dev/sdX
sync
```

## Verification

```bash
ip addr
systemctl status sshd
i2cdetect -y 1
ls /dev/spidev*
ls /sys/class/leds
```

## Learning Outcomes

- Yocto Project fundamentals
- BitBake workflow
- BSP integration
- Custom layer creation
- Device Tree Overlays
- I2C and SPI enablement
- Raspberry Pi deployment
