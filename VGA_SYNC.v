`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:48:32 12/24/2017 
// Design Name: 
// Module Name:    VGA_SYNC 
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
module VGA_SYNC(
	 input  sclk,				//Sync Clock
	 input  enable,			//VGA Sync Enable
    output [9:0] X_PIX,				//Showing Pixel's X
    output [9:0] Y_PIX,				//Showing Pixel's Y
    output Video_On,			//Show Video Enable
    output reg HSync,				//Sync Horizentally
    output reg VSync,				//Sync Vertically
	 input sel
    );
	 reg [10:0] HCounter;
	 reg [10:0] VCounter;
	 reg H_Video_On;
	 reg V_Video_On;
	 //********************************
	 reg [9:0] xres;
	 reg [9:0] yres;
	 reg [5:0] xfporch;
	 reg [5:0] yfporch;
	 reg [7:0] xspulse;
	 reg [7:0] yspulse;
	 reg [6:0] xbporch;
	 reg [6:0] ybporch;
	 //********************************
	 
	 //Sync HSync
	 always@(posedge sclk)begin
		if((HCounter >= (xres + xfporch) && HCounter < (xres + xfporch + xspulse)) || (!enable))
			HSync = 0;
		else
			HSync = 1;
	 end
	 
	 //Sync VSync
	 always@(posedge sclk)begin
		if((VCounter >= (yres + yfporch) && VCounter < (yres + yfporch + yspulse)) || (!enable))
			VSync = 0;
		else
			VSync = 1;
	 end
	 
	 //Sync H_Video_On
	 always@(posedge sclk)begin
		if(enable)begin
			if(HCounter < xres)
				H_Video_On = 1;
			else
				H_Video_On = 0;
		end
		else
			H_Video_On = 0;
	 end
	 
	 //Sync V_Video_On
	 always@(posedge sclk)begin
		if(enable)begin
			if(VCounter < yres)
				V_Video_On = 1;
			else
				V_Video_On = 0;
		end
		else
			V_Video_On = 0;
	 end
	 
	 //Produce Video_On
	 assign Video_On = H_Video_On & V_Video_On;
	 
	 //Sync X_PIX
	 assign X_PIX = HCounter;
	 
	 //Sync T_PIX
	 assign Y_PIX = VCounter;
	 
	 //this Always manage Counters
	 always@(posedge sclk)begin 
		if(enable)begin
			HCounter = HCounter + 1;
			if(HCounter == xres + xfporch + xspulse + xbporch)begin
				HCounter = 0;
				VCounter = VCounter + 1;
			end
			if(VCounter == yres + yfporch + yspulse + ybporch)
				VCounter = 0;
		end
		else begin
			HCounter = 0;
			VCounter = 0;
		end
	 end
	 
	 //initial registers
	 initial begin
		HCounter = 0;
		VCounter = 0;
		HSync = 1;
		VSync = 1;
		H_Video_On = 1;
		V_Video_On = 1;
	 end
	 
	 always@(posedge sclk)begin
		if(sel == 0)begin
			 xres = 639;
			 xfporch = 16;
			 xspulse = 96;
			 xbporch = 48;
			 yres = 479;
			 yfporch = 11;
			 yspulse = 2;
			 ybporch = 31;
		end
		else begin
			 xres = 799;
			 xfporch = 40;
			 xspulse = 128;
			 xbporch = 88;
			 yres = 599;
			 yfporch = 1;
			 yspulse = 4;
			 ybporch = 23;
		end
	 end
	 
endmodule
