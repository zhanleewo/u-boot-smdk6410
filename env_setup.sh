#!/bin/bash

MAKE=make
JOBS=4
export UBOOTDIR=`pwd`
export ARCH=arm
export O=~/build/u-boot
export CROSS_COMPILE=arm-linux-gnueabi-
export BOARD="smdk6410"
export defconfig="smdk6410_config"

echo "UBOOTDIR=$UBOOTDIR"
echo "JOBS=$JOBS"
echo "ARCH=$ARCH"
echo "O=$O"
echo "CROSS_COMPILE=$CROSS_COMPILE"
echo "BOARD=$BOARD"
echo "defconfig=$defconfig"
echo ""

if [ ! -d ./arch -o ! -d ./board ]
then
	echo "you are not in u-boot source root folder"
	return
fi

mkdir -p $O
echo -e "OK!\n"

echo "availabe commands:"
echo "	mk		- excute make with apropriate variables set"
echo "	mk_defconfig	- load default config"
echo "	mk_clean	- clean files built"
echo "	dnw_image	- download u-boot-nand.bin to board via dnw tool"

mk()
{
	$MAKE -C $UBOOTDIR O="$O" -j$JOBS $*
}

mk_defconfig()
{
	echo "load defconfig $defconfig"
	mk $defconfig
}

mk_clean()
{
	echo "clean files"
	mk clean
}

dnw_uImage()
{
	dnw $O/u-boot-nand.bin
}

