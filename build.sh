
#!/bin/bash

#set PATH and CROSS_COMPILE
export ARCH=arm64
export CROSS_COMPILE=/opt/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-

read -rn1 -p "clean build? [y/n]:" cb_rslt
echo ""

case $cb_rslt in
   y) 
   make -j 20 mrproper;;
   n) echo "Not a clean build";;
   *) echo "Clean build not chosen as default"
esac

# make -j 20 imx_v8_defconfig
make -j 20 defconfig #imx_v8_defconfig #

read -rn1 -p "menuconfig? [y/n]:" mn_rslt
echo ""

case $mn_rslt in
   y) 
   make -j 20 menuconfig;;
   *) echo "menuconfig skipped"
esac

make -j 20 

read -rn1 -p "modules? [y/n]:" mn_rslt
echo ""

case $mn_rslt in
   y) 
   make -j 20 modules
   make -j 20 INSTALL_MOD_PATH=/home/petsbm03/Desktop/imx8qxp_bitbake modules_install;;
   *) echo "modules skipped"
esac

# cp arch/arm64/boot/dts/freescale/imx8qxp-mek-a0.dtb /home/pets/Desktop/ensemble/t.dtb

cp arch/arm64/boot/dts/freescale/imx8qxp-mek-rpmsg.dtb /home/petsbm03/Desktop/imx8qxp_bitbake/imx8qxp-mek.dtb
cp arch/arm64/boot/Image /home/petsbm03/Desktop/imx8qxp_bitbake/

# scp /home/pets/Desktop/ensemble/c.dtb root@192.168.120.207:/mnt/mmc/
# scp /home/pets/Desktop/ensemble/Image root@192.168.120.207:/mnt/mmc/