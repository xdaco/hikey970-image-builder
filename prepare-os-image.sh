#!/usr/bin/env bash

source init-env.sh

DISTRO=${DISTRO:-"bionic"}
VERSION=$version
SYSTEM_SIZE=${SYSTEM_SIZE:-'1536'} # 1.5G
echo "Building image" $SYSTEM_SIZE
dd if=/dev/zero of=$bb2/rootfs.img bs=1M count=$SYSTEM_SIZE conv=sparse
mkfs.ext4 -L rootfs $bb2/rootfs.img

if [[ ! -d $bb2/loop ]]; then
	mkdir $bb2/loop
	mount -t ext4 -o loop $bb2/rootfs.img $bb2/loop
else
	echo "Loop Exsist"
	mount -t ext4 -o loop $bb2/rootfs.img $bb2/loop
fi

echo "Copying root"
echo "$gt"
cp -ar $bb3/* $bb2/loop/
echo "Umount $nl"
umount $bb2/loop

echo "Building sparse"
export SPARSE_IMG="ubuntu_$DISTRO.hikey970.$VERSION.sparse.img"
img2simg $bb2/rootfs.img $bb2/$SPARSE_IMG

echo "Cleaning Up"
rm -rf $bb2/rootfs.img

cp -rf $bb2/$SPARSE_IMG $bb1/artifacts
cd $bb1/artifacts
tar -czvf $SPARSE_IMG.tar.gz $SPARSE_IMG
rm -rf $bb2/$SPARSE_IMG

echo "ALL COMPLETE"
ls -lha $bb1/artifacts/$SPARSE_IMG
ls -lha $bb1/artifacts/SPARSE_IMG.tar.gz
sha1sum $bb1/artifacts/$SPARSE_IMG
sha1sum $bb1/artifacts/$SPARSE_IMG.tar.gz
