#!/usr/bin/env bash

source init-env.sh

install_kernel_in_rootfs () {
echo "$gb $bt COPY KERNEL $nl"
if [[ ! -f /root/workspace/Kernel-SRC/hikey970-ubuntu-kernel-source/arch/arm64/boot/Image.gz ]]; then
	cp -avrf /root/workspace/Kernel-SRC/hikey970-ubuntu-kernel-source/arch/arm64/boot/Image.gz $bb4/  
	mv $bb4/Image.gz $bb4/Image-hikey970-v4.9.gz
	echo "$gb $bt Image Copied $nl"
else
	rm -rf $bb4/Image-hikey970-v4.9.gz
	cp -avrf $kimg $bb4/  
	mv $bb4/Image.gz $bb4/Image-hikey970-v4.9.gz
	echo "$gb $bt Image Copied $nl"
fi
echo "$gb $bt COPY DEVICE TREE $nl"
if [[ ! -f $ksrc/hikey970-ubuntu-kernel-source/arch/arm64/boot/dts/hisilicon/kirin970-hikey970.dtb ]]; then
	cp -avrf $devtre $bb4/
	echo "$gb $bt DEVICE TREE Copied $nl"
else
	rm -rf $bb4/kirin970-hikey970.dtb
	cp -avrf $devtre $bb4/
	echo "$gb $bt DEVICE TREE Copied $nl"
fi
echo "$gb $bt INSTALL MODULES $nl"
	cd $tc
	aarch64-linux-gnu-gcc --version
	cd $ksrc1
	export ARCH=arm64
	make ARCH=arm64 INSTALL_MOD_PATH=$bb3/ modules_install
}

aarch64-linux-gnu-gcc --version
echo "CROSS_COMPILE=$CROSS_COMPILE"
mkdir -p $ksrc
chmod 755 $ksrc
cd $ksrc
git clone https://github.com/xdaco/hikey970-ubuntu-kernel-source.git
chmod 755 $ksrc/hikey970-ubuntu-kernel-source

thread=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
thduse=$(($thread - 2))

cd $ksrc/hikey970-ubuntu-kernel-source
export ARCH=arm64
make ARCH=arm64 mrproper > $WORKDIR/kernel-build.log
make ARCH=arm64 hikey970_defconfig  > $WORKDIR/kernel-build.log
make ARCH=arm64 -j30 > $WORKDIR/kernel-build.log
install_kernel_in_rootfs
cd $WORKDIR