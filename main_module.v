`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: S.H.Katebi
// 
// Create Date:    18:51:35 12/22/2017 
// Design Name: 
// Module Name:    main_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main_module(
	 input clk,
    output VGA_VSync,
    output VGA_HSync,
    output [1:0]	VGA_R,
    output [1:0]	VGA_G,
    output [1:0]	VGA_B
    );	
	 
	 wire cclk;
	 wire fclk;
	 wire DIP;
	 assign DIP = 0;
	 
	 wire [15:0]SAddress;
	 wire [15:0]VAddress;
	 wire [7:0]SData;
	 wire [7:0]VData;
	 
	 DCM dcm(
		 .CLK_IN1(clk),
		 .CLK_OUT1(cclk),
		 .CLK_OUT2(fclk)
	 );
	 
	 PicROM SIN (
	  .clka(fclk), // input clka
	  .addra(SAddress), // input [15 : 0] addra
	  .douta(SData) // output [7 : 0] douta
	 );
	 
	 VGA_controller VGA_Interface (
		 .Data(VData),//8bit
		 .vclk(cclk),
		 .Address(VAddress),//16bit
		 .R(VGA_R), 
		 .G(VGA_G), 
		 .B(VGA_B), 
		 .HSync(VGA_HSync), 
		 .VSync(VGA_VSync),
		 .DIP(DIP)
    );
	 
	 Sobel calculator ( 
		 .fclk(fclk), 
		 .iaddress(VAddress), 
		 .idata(SData), 
		 .oaddress(SAddress), 
		 .odata(VData)
    );
endmodule
