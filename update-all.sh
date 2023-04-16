#!/bin/bash

setSerialDev() {
    SECTION=$1  #e.g. mcu or display
    SERIAL_DEV=$(sed -e '1,/[$SECTION]/d' ~/printer_data/config/printer.cfg | grep ^serial| cut -f2 -d' ' | awk 'NR==1')
}

BOARD=fysetc-cheetah-v2
CONFIG_PATH=~/klipper-updater
MCU_CONFIG=$CONFIG_PATH/config.cheetah
DISPLAY_CONFIG=$CONFIG_PATH/config.display
RPI_CONFIG=$CONFIG_PATH/config.rpi

sudo service klipper stop
cd ~/klipper
git pull

####-----------------------------------------------------------------

make clean KCONFIG_CONFIG=$MCU_CONFIG
make menuconfig KCONFIG_CONFIG=$MCU_CONFIG
make KCONFIG_CONFIG=$MCU_CONFIG
read -p "cheetah firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

setSerialDev mcu
./scripts/flash-sdcard.sh $SERIAL_DEV $BOARD
read -p "cheetah firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

####-----------------------------------------------------------------

make clean KCONFIG_CONFIG=$DISPLAY_CONFIG
make menuconfig KCONFIG_CONFIG=$DISPLAY_CONFIG
make KCONFIG_CONFIG=$DISPLAY_CONFIG
read -p "display firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

read -p "NOW bring the display in DFU mode (JUMPER and RESET). Press [Enter] to continue flashing, or [Ctrl+C] to abort"
echo
lsusb
echo
dfu-util --list
read -p "is display in dfu mode? Press [Enter] to continue flashing, or [Ctrl+C] to abort"

make flash FLASH_DEVICE=0483:df11 KCONFIG_CONFIG=$DISPLAY_CONFIG
read -p "display firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

####-----------------------------------------------------------------

make clean KCONFIG_CONFIG=$RPI_CONFIG
make menuconfig KCONFIG_CONFIG=$RPI_CONFIG

make KCONFIG_CONFIG=$RPI_CONFIG
read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=$RPI_CONFIG

####-----------------------------------------------------------------

sudo service klipper start
