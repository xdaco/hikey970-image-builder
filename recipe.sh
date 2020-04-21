#!/usr/bin/env bash

source init-env.sh
echo "current directory............."
pwd
echo "list of files ................"
ls
. prepare-rootfs.sh
echo "****************************************************************************"
echo "Roof File System Done"
echo "****************************************************************************"
. prepare-kernel.sh
echo "****************************************************************************"
echo "Kernel preparation done System Done"
echo "****************************************************************************"
pwd 
ls
. prepare-os-image.sh
echo "****************************************************************************"
echo "Kernel preparation done System Done"
echo "****************************************************************************"
