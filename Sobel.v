`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:07 05/14/2018 
// Design Name: 
// Module Name:    Sobel 
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
module Sobel(
	 input fclk,
    input [15:0] iaddress,
    input [7:0] idata,
    output reg [15:0] oaddress,
	 output reg [7:0]odata
    );
	 
	 reg [7:0]KMap[2:0][2:0];
	 reg latchedAddress = 0;
	 reg [1:0]counter = 0;
	 reg signed [8:0]Gx;
	 reg signed [8:0]Gy;
	 
	 /*always@(posedge sclk)begin
		oaddress = iaddress;
		odata = idata;
	 end*/
	 
	 //Latch input addresss
	 always@(posedge fclk)begin
		latchedAddress = iaddress;
	 end
	 
	 //State mechine counter
	 always@(posedge fclk)begin
		counter = counter + 1;
	 end
	 
	 //4-State State Mechine
	 always@(posedge fclk)begin
		case(counter)
			(2'd0):begin//change First Row
				oaddress = (iaddress - 224) + 1;
				{KMap[0][2] , KMap[0][1] , KMap[0][0]} = {KMap[0][1] , KMap[0][0] , idata};
			end
			(2'd1):begin//change Second Row
				oaddress = iaddress + 1;
				{KMap[1][2] , KMap[1][1] , KMap[1][0]} = {KMap[1][1] , KMap[1][0] , idata};
			end
			(2'd2):begin//change Third Row
				oaddress = (iaddress + 224) + 1;
				{KMap[2][2] , KMap[2][1] , KMap[2][0]} = {KMap[2][1] , KMap[2][0] , idata};
			end
			(2'd3):begin//Calculate Kmap
				Gx = (KMap[0][0] - KMap[0][2] + 2*KMap[1][0] - 2*KMap[1][2] + KMap[2][0] - KMap[2][2])/9;
				Gy = (KMap[0][0] - KMap[2][0] + 2*KMap[0][1] - 2*KMap[2][1] + KMap[0][2] - KMap[2][2])/9;
				odata = (((Gx < 0)?(-1*Gx):(Gx)) + ((Gy < 0)?(-1*Gy):(Gy))) / 2;
			end
		endcase
	 end
endmodule
