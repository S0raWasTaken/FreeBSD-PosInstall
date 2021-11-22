#!/bin/sh
# - setting up the bootloader config
cat << EOF >> /boot/loader.conf
beastie_disable="YES"
splash_bmp_load="YES"
bitmap_load="YES"
bitmap_name="/boot/splash.bmp"
EOF

# - setting up the INT daemon file
cat << EOF >> /etc/rc.conf
dbus_enable="YES"
hald_enable="YES"
linux_enable="YES"
lightdm_enable="YES"
EOF

# - setting up xfce
echo ". /usr/local/etc/xdg/xfce4/xinitrc" > ~/.xinitrc

# - updating, upgrading and cleaning
pkg update -f
pkg upgrade
pkg autoremove
pkg clean

# - installing shell and text editor
pkg install bash neovim -y

# - installing xorg
pkg install xorg

# - installing some drivers
pkg install xf86-video-vesa xf86-video-intel

# - setting up xorg for hardware acceleration
pw groupmod video -m jru || pw groupmod wheel -m jru
pw groupmod video -m slurms || pw groupmod wheel -m slurms

# - installing fonts for xorg
pkg install urwfonts mkfontdir

# - setting up urwfonts in xorg
cat << EOF >> /etc/X11/xorg.conf
FontPath /usr/local/shared/fonts/urwfonts/
FontPath /usr/local/share/fonts/mkfontdir/
EOF

fc-cache -f 

# installing lightdm
pkg install lightdm lightdm-gtk-greeter

# installing xfce
pkg install xfce

# installing common software
pkg install chromium gimp libreoffice epdfview gnucash

# installing a compatibility layer for linux apps
pkg install emulators/linux_base-c7

# installing a bootloader beautifier
pkg install sysutils/bsd-splash-changer
