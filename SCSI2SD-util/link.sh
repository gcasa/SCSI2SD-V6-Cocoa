gcc -Wl,--enable-auto-import -Wl,--export-all-symbols -Wl,--out-implib,./SCSI2SD-util-v6.app/./SCSI2SD-util-v6.exe.a -Wl,-subsystem,windows   -o SCSI2SD-util-v6.app/./SCSI2SD-util-v6.exe \
./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Firmware/time.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal_flash_ex.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfu_load.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfuse_mem.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/quirks.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfu_file.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/lib_main.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfuse.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/hidpacket.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/hid.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal_cortex.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal_gpio.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal_flash.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/system_stm32f2xx.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/hwversion.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfu.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DFU/dfu_util.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Driver/stm32f2xx_hal_rcc.c.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/Functions.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Categories/NSString+Extensions.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Categories/MF_Base64Additions.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/ViewControllers/DeviceController.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/ConfigUtil.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/main.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/ViewControllers/SettingsController.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/DeviceFirmwareUpdate.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/AppDelegate.m.o ./obj/SCSI2SD-util-v6.obj/SCSI2SD-util/Modules/SCSI2SD_HID.m.o      -L/home/gregc/GNUstep/Library/Libraries -L/usr/GNUstep/Local/Library/Libraries -L/usr/GNUstep/System/Library/Libraries  -lgnustep-gui    -lgnustep-base    -lobjc   -lws2_32 -ladvapi32 -lcomctl32 -luser32 -lcomdlg32 -lmpr -lnetapi32 -lusb-1.0 -lsetupapi -lm -I.

cp -r ./SCSI2SD-util/Assets.xcassets SCSI2SD-util-v6.app/Resources
cp -r ./SCSI2SD-util/en.lproj/* SCSI2SD-util-v6.app/Resources
cp ./SCSI2SD-util/Info.plist SCSI2SD-util-v6.app/Info-gnustep.plist
cp ./SCSI2SD-util/SCSI2SD-V6-util-512.png SCSI2SD-util-v6.app/Resources

