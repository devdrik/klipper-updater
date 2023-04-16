# klipper updater
Lets you update klipper an the mcu, display and rpi

# How to use

In ```update-all.sh``` make sure these lines are configured to match your config names and path:

    BOARD=fysetc-cheetah-v2
    CONFIG_PATH=~/klipper-updater
    MCU_CONFIG=$CONFIG_PATH/config.cheetah
    DISPLAY_CONFIG=$CONFIG_PATH/config.display
    RPI_CONFIG=$CONFIG_PATH/config.rpi

Then run update-all.sh.
- When prompted, press enter (if no error occured)
- When the 'klipper firmware configuration' pops up, press ```q``` or ```esc```

![klipper firmware configuration image](https://github.com/devdrik/klipper-updater/blob/main/assets/klipper_firmare_configuration.png?raw=true)

- When promped bring the display in DFU-Mode. To do so, connect boot to 3V3 (jumper on the display back), then press and release the displays reset button.
- When finished, restart VORON



