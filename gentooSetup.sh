#emerge -q gentoolkit
#equery list "*" | grep dbus

vi /etc/portage/make.conf
#USE="X dbus"
echo 'VIDEO_CARDS="intel"' >> /etc/portage/make.conf
emerge -q xorg-drivers

#gpasswd -a kenter video?

emerge -qDU @world

emerge -q dmenu i3 i3status i3lock xfce4-terminal

echo -e 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
\texec startx
fi' >> .bash_profile
echo 'exec i3' > ~/.xinitrc

rc-update add dbus default
/etc/init.d/dbus start

emerge -q neofetch sudo vim
