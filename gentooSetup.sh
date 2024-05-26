#iwctl
#station wlan0 get-networks
#station wlan0 connect aterm*g
#(enter password)
#exit
#ip a

mkdir /mnt/arch

mv eduroam.8021x /var/lib/iwd
#edit edoroam.8021x

getuto

packages=(
    dev-python/pip
    dev-vcs/git
    dmenu
    eselect-repository
    fcitx
    fcitx-anthy
    gentoolkit
    i3
    i3lock
    i3status
    links
    neofetch
    noto-cjk
    noto-emoji
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

eselect repository add brave-overlay git https://gitlab.com/jason.oliveira/brave-overlay.git
emerge --sync -q brave-overlay
emerge -q brave-bin::brave-overlay

euse -E alsa
echo "net-im/zoom all-rights-reserved" >> /etc/portage/package.license
echo "net-im/zoom ~amd64" >> /etc/portage/package.accept_keywords/net-im-zoom

emerge -DUuq @world
emerge -q alsa-utils net-im/zoom

echo -e 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
\texec startx
fi' >> /home/mxvish/.bash_profile

echo 'exec i3' > /home/mxvish/.xinitrc
echo 'XTerm.vt100.faceSize: 10
XTerm.vt100.reverseVideo: true' > ~/.Xresources

echo 'GRUB_CMDLINE_LINUX_DEFAULT="psmouse.synaptics_intertouch=1 quiet snd-hda-intel.model=dell-headset-multi"' >> /etc/default/grub

echo 'clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R' > /home/$USER/.Xmodmap

wget https://raw.githubusercontent.com/mxvish/vimrc/main/vimrc
mv vimrc /home/$USER/.vimrc

mv bashrc /home/$USER/.bashrc
