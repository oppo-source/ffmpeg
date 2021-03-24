# Copyright (C) 2020 Oplus. All rights reserved.
#!/bin/bash
if [ "$NDK_HOME" = "" ]; then
	echo NDK variable not set, assuming ${HOME}/android-ndk-r20
	export NDK_HOME=${HOME}/android-ndk-r20
fi

HOST_TAG=linux-x86_64
TOOLCHAIN=$NDK_HOME/toolchains/llvm/prebuilt/$HOST_TAG
API=29

configure()
{
	CPU=$1
    PREFIX=`pwd`/android/$CPU
	ARCH=""
	SYSROOT=""
	CROSS_PREFIX=""
	CC=""
	CXX=""
	EXTRA_CFLAGS=""
	EXTRA_LDFLAGS=""
	EXTRA_LIBS=""

	if [ "$CPU" == "armv7-a" ]
	then
		ARCH=arm
		SYSROOT=$TOOLCHAIN/sysroot
		CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
		CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
		CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
		EXTRA_CFLAGS="-march=armv7-a -marm -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=neon -Iextend/dav1d/include"
		EXTRA_LDFLAGS="-Lextend/dav1d/armv7-a"
		EXTRA_LIBS="-ldav1d"
	else
		ARCH=aarch64
		SYSROOT=$TOOLCHAIN/sysroot
		CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
		CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
		CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
		EXTRA_CFLAGS="-march=armv8-a -Iextend/dav1d/include"
		EXTRA_LDFLAGS="-Lextend/dav1d/armv8-a"
		EXTRA_LIBS="-ldav1d"
	fi

	CONFIG_FLAGS="--target-os=android \
	--prefix=$PREFIX \
	--arch=$ARCH \
 	--sysroot=$SYSROOT \
	--cross-prefix=$CROSS_PREFIX \
	--cc=$CC \
	--cxx=$CXX \
	--enable-cross-compile \
	--enable-shared \
	--enable-neon \
	--enable-pic \
	--enable-asm \
	--enable-libdav1d \
	--disable-static \
	--disable-ffplay \
	--disable-network \
	--disable-ffmpeg \
	--disable-ffprobe \
	--disable-doc \
	--disable-symver \
	--disable-avdevice \
	--disable-avfilter \
	--disable-devices \
	--disable-filters \
	--disable-encoders \
	--disable-muxers \
    "

#	debug use, build libs with symbols
#	CONFIG_FLAGS="$CONFIG_FLAGS --enable-debug --disable-stripping"

	echo $CONFIG_FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" --extra-libs="$EXTRA_LIBS"
	./configure $CONFIG_FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" --extra-libs="$EXTRA_LIBS"
}

build()
{
	CPU=$1
	echo "build $CPU"
	configure $CPU
	make -j32
	make install

	cp extend/dav1d/$CPU/libdav1d.so.4 android/$CPU/lib
	if [ "$CPU" == "armv7-a" ]
	then
		cp $(pwd)/android/$CPU/lib/*.so* $(pwd)/prebuilt/lib
	else
		cp $(pwd)/android/$CPU/lib/*.so* $(pwd)/prebuilt/lib64
	fi

	make clean
}

make clean
build armv7-a
build armv8-a