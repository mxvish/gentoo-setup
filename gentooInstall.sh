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
links get.gentoo.org
#find Stage 3 openrc and save tar.xz from distfiles.gentoo.org
tar xpf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo 'MAKEOPTS="-j11 -l12"' >> etc/portage/make.conf

cp -L /etc/resolv.conf /mnt/gentoo/etc/
mount -t proc /proc /mnt/gentoo/proc
mount -R /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount -R /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount -B /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash
source /etc/profile

emerge-webrsync -q

echo 'ACCEPT_LICENSE="@BINARY-REDISTRIBUTABLE"
USE="dracut elogind mount standalone X pulseaudio"
FEATURES="getbinpkg"
INPUT_DEVICES="synaptics libinput"' >> etc/portage/make.conf

#emerge --sync -q
#etc-update --automode -5

getuto
emerge -DUuq @world

echo "Asia/Tokyo" > /etc/timezone
emerge --config timezone-data

echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

#configuring the kernel
emerge -q gentoo-kernel-bin linux-firmware

#configuring the system
emerge -q genfstab
#mkdir /mnt/efi
#mount /dev/nvme0n1p1 /mnt/efi
genfstab -U / >> etc/fstab

echo 'mxvish' > /etc/hostname
emerge -q dhcpcd iwd
rc-update add dhcpcd default
rc-update add iwd default

mkdir /etc/iwd
echo '
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=resolvconf' > /etc/iwd/main.conf

#echo -e '127.0.0.1\tmxvish.localdomain\tmxvish' >> /etc/hosts
passwd

#configuring the bootloader
echo "sys-fs/lvm2 lvm" >> /etc/portage/package.use/lvm
emerge -q grub os-prober

grub-install --efi-directory=/mnt/efi/
echo 'GRUB_DISABLE_OS_PROBER=false
GRUB_CMDLINE_LINUX_DEFAULT="psmouse.synaptics_intertouch=1 quiet snd-hda-intel.model=dell-headset-multi"' >> /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

#finalizing
useradd -G wheel,audio,video -m mxvish
passwd mxvish

exit
reboot
