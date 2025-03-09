#iwctl
#station wlan0 get-networks
#station wlan0 connect aterm*g
#(enter password)
#exit
#ip a

mkdir /mnt/arch

mv eduroam.8021x /var/lib/iwd
#edit edoroam.8021x

#euse -E alsa

emerge --sync -q brave-overlay
echo "dev-libs/libpthread-stubs **" >> /etc/portage/package.accept_keywords/libpthread-stubs
echo 'dev-python/setuptools python_targets_python3_11' > /etc/portage/package.use/setuptools
echo ">=app-i18n/fcitx-qt-5.1.5-r2 qt5" > /etc/portage/package.use/fcitx
echo "app-i18n/mozc fcitx5" > /etc/portage/package.use/mozc

#echo "net-im/zoom all-rights-reserved" >> /etc/portage/package.license
#echo "net-im/zoom ~amd64" >> /etc/portage/package.accept_keywords/net-im-zoom

rm -rf /var/cache/edb/dep/*
getuto
emerge -DUuq @world

packages=(
    blueman
    dev-python/pip
    dev-vcs/git
    dmenu
    eselect-repository
    exfatprogs
    fcitx
    fcitx-config-tool
    gentoolkit
    i3
    i3lock
    i3status
    links
    mozc
    neofetch
    noto-cjk
    noto-emoji
    pulseaudio
    ranger
    scrot
    vim
    x11-misc/xclip
    xfce4-terminal
    xmodmap
    xorg-server
    xrandr
    xterm
)

for i in "${packages[@]}"; do emerge -q "$i"; done

echo -e 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
\texec startx
fi' >> /home/mxvish/.bash_profile

echo 'exec i3' > /home/mxvish/.xinitrc

echo 'clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R' > /home/$USER/.Xmodmap

mkdir /etc/X11/xorg.conf.d
echo 'Section "InputClass"
     Identifier "libinput touchpad catchall"
     MatchIsTouchpad "on"
     MatchDevicePath "/dev/input/event*"
     Option "Tapping" "True"
     Option "TappingDrag" "True"
     Driver "libinput"
EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

wget https://raw.githubusercontent.com/mxvish/vimrc/main/vimrc
mv vimrc /home/$USER/.vimrc
chown $USER:$USER /home/$USER/.vimrc

mv bashrc /home/$USER/.bashrc
chown $USER:$USER /home/$USER/.bashrc

curl -s https://raw.githubusercontent.com/mxvish/i3config/main/config > ~/.config/i3/config
chown $USER:$USER /home/$USER/.config/i3/config
wget -q https://raw.githubusercontent.com/mxvish/i3status/main/i3status.conf
mv i3status.conf /etc/
