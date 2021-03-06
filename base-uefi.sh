#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

#pacman -S mtools dosfstools avahi xdg-user-dirs xdg-utils nfs-utils inetutils dnsutils  bash-completion  virt-manager qemu qemu-arch-extra edk2-ovmf  bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g 

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant linux-headers gvfs gvfs-smb nfs-utils bluez bluez-utils cups hplip pipewire alsa-utils pipewire-alsa pipewire-pulse acpi acpi_call pipewire-jack openssh reflector rsync terminus-font
 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
#systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid

useradd -m csscoder
echo csscoder:password | chpasswd
# usermod -aG libvirt csscoder

echo "csscoder ALL=(ALL) ALL" >> /etc/sudoers.d/csscoder


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

