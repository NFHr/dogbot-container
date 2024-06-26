#!/bin/bash
flag=0

if [ ! -f /etc/udev/rules.d/ydlidar.rules ]; then
    echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666", GROUP:="dialout", SYMLINK+="ydlidar"' | sudo tee /etc/udev/rules.d/ydlidar.rules >/dev/null
    echo '"/etc/udev/rules.d/ydlidar.rules" Created'
    flag=1
fi

if [ ! -f /etc/udev/rules.d/ydlidar-V2.rules ]; then
    echo 'KERNEL=="ttyACM*", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE:="0666", GROUP:="dialout", SYMLINK+="ydlidar"' | sudo tee /etc/udev/rules.d/ydlidar-V2.rules >/dev/null
    echo '"/etc/udev/rules.d/ydlidar-V2.rules" Created'
    flag=1
fi

if [ ! -f /etc/udev/rules.d/ydlidar-2303.rules ]; then
    echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="2303", MODE:="0666", GROUP:="dialout", SYMLINK+="ydlidar"' | sudo tee /etc/udev/rules.d/ydlidar-2303.rules >/dev/null
    echo '"/etc/udev/rules.d/ydlidar-2303.rules" Created'
    flag=1
fi

if [ ! -f /etc/udev/rules.d/arduino.rules ]; then
	sudo systemctl stop brltty-udev.service
    sudo systemctl mask brltty-udev.service
    sudo systemctl stop brltty.service
    sudo systemctl disable brltty.service
    echo 'KERNEL=="ttyUSB*", ATTRS{idProduct}=="7523", ATTRS{idVendor}=="1a86", MODE:="0666", GROUP:="dialout", SYMLINK+="arduino"' | sudo tee /etc/udev/rules.d/arduino.rules >/dev/null
    echo '"/etc/udev/rules.d/arduino.rules" Created'
    flag=1
fi

if [ $flag -eq 1 ]; then
    sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger
fi