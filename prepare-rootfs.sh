#!/usr/bin/env bash
source init-env.sh

cp -a $bf/fastboot.efi $bb10/
cp -a $bf/grub.cfg $bb9/
cp -a $bf/1920x1080.bin $bb22/
chmod 755 $bb22/1920x1080.bin
chmod 444 $bb9/grub.cfg
cp -a $bf/initramfs-v4.9 $bb4/
chmod 644 $bb4/initramfs-v4.9
cp -a $bf/wl18xx-conf.bin $bb15/
chown 0.0 $bb15/wl18xx-conf.bin
chmod 755 $bb15/wl18xx-conf.bin
cp -a $bf/LICENSE $bb2/		
cp -a $bf/11-image-support $bb12/
cp -a $bf/libmali.so $bb21/	
cp -a $bf/keyrings/* $bb19/
touch $bb7/init.sh
echo "Username for the default user: $usenm"
echo "Password for the default user: $pword"
echo "#!/bin/bash" |  tee -a $bb7/init.sh
echo "set -ue" |  tee -a $bb7/init.sh
echo "useradd -g  -m -s /bin/zsh $usenm" |  tee -a $bb7/init.sh
echo "echo $usenm:$pword | chpasswd" |  tee -a $bb7/init.sh
qts='"'
hk="hikey970"
adr="127.0.0.1 hikey970"
echo "echo $qts#made by $usenm$qts >> /home/$usenm/.zshrc" |  tee -a $bb7/init.sh
echo "passwd -d root" |  tee -a $bb7/init.sh
echo "rm -rf /debootstrap" |  tee -a $bb7/init.sh
echo "apt clean && apt autoclean" |  tee -a $bb7/init.sh
echo "rm -f /etc/ssh/ssh_host_*" |  tee -a $bb7/init.sh
echo "echo $qts$hk$qts > /etc/hostname" |  tee -a $bb7/init.sh
echo "echo $qts$adr$qts >> /etc/hosts" |  tee -a $bb7/init.sh
echo "exit 0" |  tee -a $bb7/init.sh
echo "exit" |  tee -a $bb7/init.sh
echo "rm /root/init.sh" |  tee -a $bb7/init.sh
chmod 0755 $bb7/init.sh
echo "$bb7/init.sh" $CRE
touch $bb7/locale.sh
echo "#!/bin/bash" |  tee -a $bb7/locale.sh
echo "set -ue" |  tee -a $bb7/locale.sh
echo "locale-gen en_US.UTF-8" |  tee -a $bb7/locale.sh
echo "update-locale LANG=en_US.UTF-8" |  tee -a $bb7/locale.sh
echo "rm /root/locale.sh" |  tee -a $bb7/locale.sh
echo "exit 0" |  tee -a $bb7/locale.sh
echo "exit" |  tee -a $bb7/locale.sh
chmod 0755 $bb7/locale.sh
echo "$bb7/locale.sh" $CRE
mirror=http://ftp.tu-chemnitz.de/pub/linux/ubuntu-ports/
touch $bb5/rc.local
echo "#!/bin/bash" |  tee -a $bb5/rc.local
echo "# re-generate ssh host key" |  tee -a $bb5/rc.local
echo "test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server" |  tee -a $bb5/rc.local
echo "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" |  tee -a $bb5/rc.local	
chmod 775 $bb5/rc.local
echo "$bb5/rc.local" $CRE
clear
ap=""
pw=""
touch $bb11/01-dhcp.yaml
chmod 755 $bb11/01-dhcp.yaml
echo "network:" |  tee -a $bb11/01-dhcp.yaml
echo " version: 2" |  tee -a $bb11/01-dhcp.yaml
echo " renderer: NetworkManager" |  tee -a $bb11/01-dhcp.yaml
echo " ethernets:" |  tee -a $bb11/01-dhcp.yaml
echo "     enp6s0:" |  tee -a $bb11/01-dhcp.yaml
echo "        dhcp4: true" |  tee -a $bb11/01-dhcp.yaml
echo "        dhcp6: true" |  tee -a $bb11/01-dhcp.yaml
echo "network:" |  tee -a $bb11/01-dhcp.yaml
echo "    version: 2" |  tee -a $bb11/01-dhcp.yaml
echo "    wifis:" |  tee -a $bb11/01-dhcp.yaml
echo "        wlan0:" |  tee -a $bb11/01-dhcp.yaml
echo "             renderer: NetworkManager" |  tee -a $bb11/01-dhcp.yaml
echo "             dhcp4: true" |  tee -a $bb11/01-dhcp.yaml
echo "             dhcp6: true" |  tee -a $bb11/01-dhcp.yaml
echo "             access-points:" |  tee -a $bb11/01-dhcp.yaml
echo "                 $ap" |  tee -a $bb11/01-dhcp.yaml
echo "                     password: $pw" |  tee -a $bb11/01-dhcp.yaml
export DEBIAN_FRONTEND=noninteractive
DISTRO=${DISTRO:-"bionic"}
MIRRORS=${MIRRORS:-}
SOFTWARE=${SOFTWARE:-"ssh,zsh,tmux,linux-firmware,vim-nox,net-tools,network-manager,wget,tasksel,gnupg2,nano,\
net-tools,wpasupplicant,parted,fakeroot,kernel-wedge,build-essential,python-pip,kernel-package,ccache,libssl-dev,gcc"}
qemu-debootstrap --arch arm64 --include=$SOFTWARE --components=main,multiverse,universe bionic $bb3 $mirror
echo ""
echo "*****************************************************************************************************"
echo "*******************************qemu-debootstrap completed********************************************"
echo "*****************************************************************************************************"
echo ""
echo "$gb $bt INITIALIZE SYSTEM $nl"
echo "$gb $bt UPDATE /etc/apt/sources.list $nl"
cp -arv $bf/sources.list $bb23
echo "$gb $bt COPY INIT.SH FOR SETUP $nl"
cp -arv $bf/init.sh $bb5
chmod 755 $bb5/init.sh
chroot $bb3 /root/init.sh
chroot $bb3 /usr/bin/apt-get install -yq nodejs-dev
chroot $bb3 locale-gen en_US.UTF-8
chroot $bb3 /usr/bin/apt-get autoremove -y
chroot $bb3 /bin/rm -rf /var/lib/apt/lists/*
chroot $bb3 /bin/rm -rf /var/cache/apt/archives/*
chroot $bb3 /usr/bin/apt-get update -yq
cd $WORKDIR
