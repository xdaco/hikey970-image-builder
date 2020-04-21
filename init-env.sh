#!/usr/bin/env bash
WORKDIR=$(pwd)
###Main Directory
bb1=$WORKDIR
###SRC stage Directory $WORKDIR/buntu-SRC/
bbb2=$bb1/Ubuntu-SRC
###SRC BUILD Directory $WORKDIR/Ubuntu-SRC/build
bb2=$bb1/Ubuntu-SRC/build
### Rootfs Directory $WORKDIR/Ubuntu-SRC/build/rootfs
bb3=$bb2/rootfs
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/boot
bb4=$bb3/boot
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/etc
bb5=$bb3/etc
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/lib
bb6=$bb3/lib
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/root
bb7=$bb3/root
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/boot/EFI
bb8=$bb4/EFI
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/boot/grub
bb9=$bb4/grub
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/boot/EFI/BOOT
bb10=$bb8/BOOT
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/etc/netplan
bb11=$bb5/netplan
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/etc/update-motd.d
bb12=$bb5/update-motd.d
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/lib/firmware
bb13=$bb6/firmware
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/lib/modules
bb14=$bb6/modules
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/lib/firmware/ti-connectivity
bb15=$bb13/ti-connectivity
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/usr
bb17=$bb3/usr
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/usr/share
bb18=$bb17/share
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/usr/share
bb19=$bb18/keyrings
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/usr/lib
bb20=$bb17/lib
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/usr/lib/aarch64-linux-gnu
bb21=$bb20/aarch64-linux-gnu
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/lib/firmware/edid
bb22=$bb13/edid
### Directory $WORKDIR/Ubuntu-SRC/build/rootfs/etc/apt
bb23=$bb5/apt/
###SRC BINARIES Directory $WORKDIR/Binaries
bf=$bb1/Binaries
###KERNEL SRC FILES ROOT
ksrc=$bb1/Kernel-SRC
###KERNEL SRC FILES
ksrc1=$ksrc/hikey970-ubuntu-kernel-source
###KERNEL CONFIG FILES $WORKDIR/Binaries
kconf=$bb1/Kernel-Configs
tc=$bb1/gcc-arm-8.2
###Kernel Image
kimg=$ksrc1/arch/arm64/boot/Image.gz
### Device Tree
devtre=$ksrc1/arch/arm64/boot/dts/hisilicon/kirin970-hikey970.dtb
### Needed Packages to build image
usenm="bor"
pword="forhumans"
DISTRO=18.04
version=0.1.0
export DEBIAN_FRONTEND=noninteractive
export export TERM=xterm