##when root partition is /dev/sda3
#mkfs.ext4 /dev/sda3
#mkdir /mnt/gentoo
#mount /dev/sda3 /mnt/gentoo/

#mkdir /efi
##when efi partition is /dev/sda1
#mount /dev/sda1 /efi/

#download stage3 file from https://www.gentoo.org/downloads/
tar xpvf /home/$HOSTNAME/Downloads/stage3-amd64-openrc-20251109T170053Z.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash
source /etc/profile

emerge-webrsync

echo '
ACCEPT_LICENSE="@BINARY-REDISTRIBUTABLE"
# Appending getbinpkg to the list of values within the FEATURES variable
FEATURES="${FEATURES} getbinpkg"
MAKEOPTS="-j4 -l5"' >> /etc/portage/make.conf

ln -sf /usr/share/zoneinfo/Japan /etc/localtime

sed -i 's/# en_US.UTF-8       UTF-8  # American English (United States)/en_US.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
locale-gen

getuto
emerge -quDU @world

emerge -q gentoo-kernel-bin linux-firmware

emerge -q dhcpcd genfstab
genfstab -U / >> /etc/fstab

echo 'mxvish' > /etc/hostname
rc-update add dhcpcd default
rc-service dhcpcd start

echo -e "
127.0.0.1\tlocalhost
::1\t\tlocalhost
127.0.0.1\t$HOSTNAME.localdomain\t$HOSTNAME" >> /etc/hosts

passwd

useradd -G wheel,audio,video -m $HOSTNAME
passwd $HOSTNAME
