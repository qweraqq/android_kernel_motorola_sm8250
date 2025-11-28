TARGET_KERNEL_CONFIG := \
    vendor/kona-perf_defconfig \
    vendor/ext_config/moto-kona.config
TARGET_KERNEL_CONFIG += vendor/ext_config/nio-default.config

cat arch/arm64/configs/vendor/kona-perf_defconfig arch/arm64/configs/vendor/ext_config/moto-kona.config arch/arm64/configs/vendor/ext_config/nio-default.config > arch/arm64/configs/nio_defconfig

echo "CONFIG_KSU=y" >> arch/arm64/configs/nio_defconfig
echo "CONFIG_KSU_KPROBES_HOOK=n" >> arch/arm64/configs/nio_defconfig
// echo "CONFIG_KPROBES=n" >> arch/arm64/configs/nio_defconfig
echo "out/" >> .gitignore

export CLANG_TRIPLE=aarch64-linux-gnu
CLANG=~/clang/clang-r536225/bin
PATH=$CLANG:$PATH
export PATH

export ARCH=arm64
export DEFCONFIG=nio_defconfig
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build
export KBUILD_BUILD_TIMESTAMP="Tue Sep 19 04:32:01 CDT 2023"
KBUILD_BUILD_TIMESTAMP="Tue Sep 19 04:32:01 CDT 2023"

# rm -rf out/
mkdir -p out
make O=out CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 $DEFCONFIG

make O=out CC=clang LLVM=1 LLVM_IAS=1 AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip LD=ld.lld CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j4 Image