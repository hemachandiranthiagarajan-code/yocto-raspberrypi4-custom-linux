# Raspberry Pi 4 Custom Embedded Linux using Yocto

## Overview

This project demonstrates the development of a custom Embedded Linux distribution for Raspberry Pi 4 using the Yocto Project (Kirkstone).

### Features

- Raspberry Pi 4 BSP integration
- Automatic Wi-Fi connection during boot
- OpenSSH server support
- Custom Yocto layer creation (`meta-rpiwifi`)
- GPIO LED support through Device Tree Overlay
- I2C support
- SPI support
- BMP280 sensor integration
- End-to-end image build and deployment workflow

## Repository Structure

```text
.
├── README.md
├── BUILD_GUIDE.md
├── LICENSE
├── device-tree/
│   └── rpi-led-overlay.dts
└── recipes/
    └── core-image-base.bbappend
```

## Technology Stack

- Yocto Project (Kirkstone)
- Poky
- BitBake
- meta-raspberrypi
- meta-openembedded
- Raspberry Pi 4
- OpenSSH
- Device Tree Overlays
- I2C
- SPI

## Build

Follow the complete instructions in `BUILD_GUIDE.md`.

```bash
source poky/oe-init-build-env build-rpi
bitbake core-image-base
```

## Hardware Features Verified

- Wi-Fi
- SSH
- GPIO LED Overlay
- I2C
- SPI
- BMP280 Sensor Detection

## Author

T Hemachandiran

Associate Engineer | Embedded Linux | Yocto Project | Linux Kernel Development
