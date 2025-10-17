#!/bin/bash

# apt-get update
# apt-get build-dep linux
# apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev p7zip-full p7zip-rar dwarves cmake libdwarf-dev libdw-dev pkgconf linux-tools-generic linux-tools-common bpfcc-tools libbpfcc libbpfcc-dev linux-generic libbpf-dev 

# https://www.reddit.com/r/Ubuntu/comments/1cm97bg/libncurses5dev/
# curl -O http://launchpadlibrarian.net/648013231/libtinfo5_6.4-2_amd64.deb
# sudo dpkg -i libtinfo5_6.4-2_amd64.deb
# curl -O http://launchpadlibrarian.net/648013227/libncurses5_6.4-2_amd64.deb 
# sudo dpkg -i libncurses5_6.4-2_amd64.deb


# git clone https://github.com/xiangfeidexiaohuo/Snapdragon-LLVM.git ~/Snapdragon-clang
# git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 ~/aarch64-linux-android-4.9
# git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 ~/arm-linux-androideabi-4.9

CLANG=~/Snapdragon-clang/bin
GCC32=~/arm-linux-androideabi-4.9/bin
GCC64=~/aarch64-linux-android-4.9/bin


export CLANG_TRIPLE=aarch64-linux-gnu
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-
PATH=$CLANG:$GCC64:$GCC32:$PATH
export PATH


# Vars
export HEADER_ARCH=$ARCH
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build
export KBUILD_BUILD_TIMESTAMP="Tue Sep 19 04:32:01 CDT 2023"
KBUILD_BUILD_TIMESTAMP="Tue Sep 19 04:32:01 CDT 2023"

DATE_START=$(date +"%s")
echo "-------------------"
echo "Making Kernel:"
echo "-------------------"
echo

rm -rf out

make -j$(nproc --all) CC=clang O=out ARCH=arm64 O=out nio_defconfig

make -j$(nproc --all) CC=clang O=out ARCH=arm64


echo
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

# kernel="out/arch/arm64/boot/Image"