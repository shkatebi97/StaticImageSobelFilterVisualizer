`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:34 12/24/2017 
// Design Name: 
// Module Name:    Pixel_Generator 
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
module Pixel_Generator(
    input EDOC,
	 input data,
	 input [0:9] X_PIX,
	 input [0:9] Y_PIX,
    input Video_On,
    input clk,
	 output reg [15:0] address,
    output reg [1:0] R,
    output reg [1:0] G,
    output reg [1:0] B,
	 input sel
    );
	 reg [9:0] xres;
	 reg [9:0] yres;
	 
	 parameter black = 6'b000000 , red = 6'b110000 , green = 6'b001100 , blue = 6'b000011;
	 
	 always@(*)begin
		if(Video_On)begin
			if(X_PIX > ((xres - yres)/2) && X_PIX <= xres - ((xres - yres)/2))begin
				if((X_PIX >= ((xres/2) - 112)) && (X_PIX < ((xres/2) + 112)) && (Y_PIX >= ((yres/2) - 112)) && (Y_PIX < ((yres/2) + 112)))begin
					{R[0] , G[0] , B[0]} = {data , data , data};
					{R[1] , G[1] , B[1]} = {data , data , data};
				end
				else begin
					{R[0] , G[0] , B[0]} = 3'b000;
					{R[1] , G[1] , B[1]} = 3'b000;
				end
			end
			else begin
				{R , G , B} = black;
			end
		end
		else begin
			{R , G , B} = black;
		end
	 end
	 
	 always@(posedge clk)begin
		if(Video_On)begin
			if((X_PIX >= ((xres/2) - 112) && X_PIX < ((xres/2) + 112)) && (Y_PIX >= ((yres/2) - 112) && Y_PIX < ((yres/2) + 112)))
				address = ((Y_PIX - ((yres/2) - 112)) * 224) + (X_PIX - ((xres/2) - 112));
			else
			address = 0;
		end
		else begin
			address = 0;
		end
	 end
	 
	 always@(posedge clk)begin
		if(sel == 0)begin
			xres = 640;
			yres = 480;
		end
		else begin
			xres = 800;
			yres = 600;
		end
	 end
	 
endmodule
