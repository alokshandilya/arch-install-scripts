#!/bin/bash

touch /etc/X11/xorg.conf.d/30-touchpad.conf
echo "Section \"InputClass\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Identifier \"touchpad\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        MatchIsTouchpad \"on\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Driver \"libinput\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Option \"Tapping\" \"on\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Option \"TappingButtonMap\" \"lrm\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Option \"NaturalScrolling\" \"on\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "        Option \"ScrollMethod\" \"twofinger\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
echo "EndSection" >> /etc/X11/xorg.conf.d/30-touchpad.conf
