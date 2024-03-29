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
    links
    neofetch
    vim
)

for i in "${packages[@]}"; do emerge -q "$i"; done
