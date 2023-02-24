ip link

#assume network name is wlp2s0
echo 'ctrl_interface=/run/wpa_supplicant
update_config=1' >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf

wpa_passphrase $SSID $WIFI_PASSWORD >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf

vi /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
# Delete not hashed psk
wpa_supplicant -Bi wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf

#fdisk -l
#cfdisk /dev/nvme0n1 #if SSD or HDD is /dev/nvme0n1

#(create / and swap partition(type=linux swap) and remenber device name)
#(for example)
#
#root partition:  /dev/nvme0n1p5
#swap partition: /dev/nvme0n1p6
#efi system: /dev/nvme0n1p1

#Format & mount partitions
#mkfs.ext4 /dev/nvme0n1p5
#mount /dev/nvme0n1p5 /mnt/gentoo
#mkswap /dev/nvme0n1p6
#swapon /dev/nvme0n1p6

cd /mnt/gentoo
links https://gentoo.org/downloads/mirrors
#JP -> http://ftp.riken.ac.jp/Linux/gentoo
#press down arrow key
#move down to /Linux/gentoo/releases/amd64/autobuilds
#choose the latest directory
#download stage3-amd64-*.tar.xz
#press q to quit links

tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
vi etc/portage/make.conf
#add or edit it as follows
#CHOST="x86_64-pc-linux-gnu"
#COMMON_FLAGS="-02 -march=znver2 -pipe"
#MAKEOPT="-j8" #8 = 16(RAM) / 2
#ACCEPT_LICENSE="*"

mirrorselect -i -o >> etc/portage/make.conf
#choose a https server per institutio

mkdir -p etc/portage/repos.conf
cp usr/share/portage/config/repos.conf etc/portage/repos.conf/gentoo.conf
cp -L /etc/resolv.conf etc/

mount -t proc /proc proc
mount -R /sys sys
mount --make-rslave sys
mount -R /dev dev
mount --make-rslave dev

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"

#change /boot to /mnt/efi
#mkdir /mnt/efi
#mount /dev/nvme0n1p1 /mnt/efi
emerge-webrsync
emerge -q --sync
eselect profile list
eselect profile set 5 #desktop(stable)

nano /etc/portage/make.conf
#USE="-bluetooth -systemd -qewebengine -webengine -sqlite"
emerge -quDN @world

echo "Asia/Tokyo" > /etc/timezone
emerge --config timezone-data
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

eselect locale list
eselect locale set 4 #choose en_US.utf8
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

emerge -q gentoo-sources linux-firmware pciutils genkernel

echo -e '/dev/nvme0n1p1\t/mnt/efi\tvfat\tdefaults\t0 2' >> /etc/fstab #because EFI is vfat
eselect kernel set 1
genkernel all

echo -e '/dev/nvme0n1p6\tnone\tswap\tsw\t0 0
/dev/nvme0n1p5\t/\text4\tnoatime\t0 1' >> /etc/fstab
sed -ie 's/localhost/kenter/g' /etc/conf.d/hostname

emerge -qn netifrc
echo 'config_wlp2s0="dhcp"' > /etc/conf.d/net

cd /etc/init.d
ln -s net.lo net.wlp2s0
rc-update add net.wlp2s0 default

#systemctl enable --now dhcpcd?

sed -ie 's/127.0.0.1\t/127.0.0.1\tkenter /g' /etc/hosts
passwd #should be a mix of upper and lower case letters, digits and other characters

#systemd-firstboot --prompt --setup-machine-id #or edit /etc/hostname & /etc/machine-id by myself?
#systemctl preset-all --preset-mode=enable-only

emerge -q sysklogd
rc-update add sysklogd default

emerge -q e2fsprogs dosfstools wpa_supplicant

echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge -q dhcpcd grub

grub-install --target=x86_64-efi --efi-directory=/mnt/efi/
grub-mkconfig -o /boot/grub/grub.cfg

#setup wifi according to https://wiki.gentoo.org/wiki/Wpa_supplicant#Using_OpenRC

#echo 'ctrl_interface=/run/wpa_supplicant
#update_config=1' >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
#wpa_passphrase $SSID $WIFI_PASSWORD >> /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
#vi /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
## Delete not hashed psk
#wpa_supplicant -Bi wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
#systemctl enable --now wpa_supplicant@wlp2s0

exit
reboot

#kenter login: root
#passwd: root passwd

#cd / ?
useradd -m -G users,wheel,audio -s /bin/bash kenter
passwd kenter

rm /stage3-*
