## This is the begining of My FPGA Projects :)

This project produce the Sobel output image from a static image stored in the "PicROM" in the middle of the screen.
* The acceptable image is 224x224 px 8bit grayscale.
* you can change fram rate and resolution with changing Parameters Value and DCM Output Value. This project support two resolution and frame rate in same time. This mean you can set two resolution and frame rate in module and program it on FPGA and change between these two resolution with a key. if you want to use this feature you should add "input DIP" to module and remove "wire DIP;" and "assign DIP = 0;".
* For better understanding look at ([Resolution.png](https://gitlab.com/s.h.katebi97/SobelStaticImage/Resolution.png)) in the project, by default Resolution is 640x480 and 60Hz Frame Rate
* This project shows output image on VGA with VGA_VSync and VGA_HSync and RGB pins.
* If you want to change the accuracy of Sobel module you can go to VGA_controller.v line 60 and change the number in range of "0-255". The default value is 100.

## The bit file only work on Posedge Posedge-One:
* Rev 1.1 ([public domain](http://posedge.ir/product/posedge-one/))([.UCF rev1.3](https://raw.githubusercontent.com/mhaghighi/posedge_one/master/Posedge_One/ucf/PosedgeOne_1V3.ucf))([Schema](https://raw.githubusercontent.com/mhaghighi/posedge_one/eeb0cc58cbb8c0771e513168f4aac55a2217c5c0/Posedge_One/schematics/posedgeone_1V1_sch.pdf))
* With Posedge MegaWing LogiX-1 rev 1.2 ([public domain](http://posedge.ir/product/logix-1_megawing/))([.UCF](https://raw.githubusercontent.com/mhaghighi/posedge_one/master/Wings/LogiX1_MegaWing/docs/ucf/Posedge_logiX1_megawing_1V2.ucf))([Schema](https://github.com/mhaghighi/posedge_one/raw/master/Wings/LogiX1_MegaWing/docs/schematic/posedge-LogiX1_megawing_1v1_sch.pdf)) connected.
* If you want to use it on other FPGA you should easily change the main_module.ucf and Chip and Generate Programming File again.