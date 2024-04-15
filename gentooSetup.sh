#iwctl
#station wlan0 get-networks
#station wlan0 connect aterm*g
#(enter password)
#exit
#ip a

mkdir /mnt/arch

mv eduroam.8021x /var/lib/iwd
#edit edoroam.8021x

packages=(
    dmenu
    i3
    i3lock
    links
    neofetch
    vim
    xorg-server
    xterm
)

for i in "${packages[@]}"; do emerge -q "$i"; done

echo -e 'if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
\texec startx
fi' >> /home/mxvish/.bash_profile

echo 'exec i3' > /home/mxvish/.xinitrc
echo 'XTerm.vt100.faceSize: 10
XTerm.vt100.reverseVideo: true' > ~/.Xresources
