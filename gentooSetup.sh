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
    dev-vcs/git
    dmenu
    eselect-repository
    gentoolkit
    i3
    i3lock
    i3status
    links
    neofetch
    noto-cjk
    ranger
    vim
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

echo 'GRUB_CMDLINE_LINUX_DEFAULT="psmouse.synaptics_intertouch=1 snd-hda-intel.model=dell-headset-multi"' >> /etc/default/grub
