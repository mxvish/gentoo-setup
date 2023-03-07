#emerge -q gentoolkit
#equery list "*" | grep dbus

vi /etc/portage/make.conf
#USE="X"
echo 'VIDEO_CARDS="intel"' >> /etc/portage/make.conf
emerge -q xorg-drivers

#gpasswd -a kenter video?

emerge -qDU @world

emerge -q dmenu i3 i3status i3lock xfce4-terminal

echo 'exec startx' >> .bash_profile
echo 'Xft.dpi: 120' > ~/.Xresources
echo 'xrdb ~/.Xresources
exec i3' > .xinitrc

#rc-update add dbus default
#/etc/init.d/dbus start

emerge -q neofetch nm-applet ranger sudo vim xrandr

rc-update add NetworkManager default
rc-service NetworkManager start

reboot
