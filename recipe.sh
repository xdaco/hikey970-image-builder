#!/usr/bin/env bash

source init-env.sh
echo "current directory............."
pwd
echo "list of files ................"

. prepare-rootfs.sh

echo ""
echo "****************************************************************************"
echo "Roof File System Done"
echo "****************************************************************************"
echo ""

. prepare-kernel.sh

echo ""
echo "****************************************************************************"
echo "Kernel preparation done System Done"
echo "****************************************************************************"
echo ""

. prepare-os-image.sh

echo ""
echo "****************************************************************************"
echo "Os image preparation complete"
echo "****************************************************************************"
echo ""
