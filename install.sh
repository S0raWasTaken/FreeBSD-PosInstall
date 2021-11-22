# - configurando arquivo de boot
cat << EOF >> /boot/loader.conf
beastie_disable="YES"
splash_bmp_load="YES"
bitmap_load="YES"
bitmap_name="/boot/splash.bmp"
EOF

# - configurando arquivo do daemon int
cat << EOF >> /etc/rc.conf
dbus_enable="YES"
hald_enable="YES"
linux_enable="YES"
lightdm_enable="YES"
EOF

# configurando xfce
echo ". /usr/local/etc/xdg/xfce4/xinitrc" > ~/.xinitrc

# - atualizando pkg e controlando sistema 
pkg update -f
pkg upgrade
pkg autoremove
pkg clean

# - instalando shell e editor
pkg install bash neovim -y

# - instalando x.org
pkg install xorg

# - instalando alguns drivers 
pkg install xf86-video-vesa xf86-video-intel

# - configurar X.org para aceleração 3D
pw groupmod video -m jru || pw groupmod wheel -m jru
pw groupmod video -m slurms || pw groupmod wheel -m slurms

# - instalando fonts para o X.org
pkg install urwfonts mkfontdir

# - configurando X.org para urwfonts~
cat << EOF >> /etc/X11/xorg.conf
FontPath /usr/local/shared/fonts/urwfonts/
FontPath /usr/local/share/fonts/mkfontdir/
EOF

fc-cache -f 

# instlaando lightdm
pkg install lightdm lightdm-gtk-greeter

# instalando xfce
pkg install xfce

# instalando um kit para uso diario do freeBSD

pkg install chromium gimp libreoffice epdfview gnucash

# instalando pacote para compatibilidade binária com o linux

pkg install emulators/linux_base-c7

# instalando apps para deixar o boot mais bonito
pkg install sysutils/bsd-splash-changer
