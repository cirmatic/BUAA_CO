`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:49 10/30/2024 
// Design Name: 
// Module Name:    DM 
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
module DM(
	input wire [31:0] A,
	input wire [31:0] WD,
	input wire BH,  // judge use LS or not
	input wire BHExt,
	input wire WE,
	input wire [31:0] pc,
	input wire clk,
	input wire reset, 
	output reg [31:0] RD
    );
	 
	 reg [31:0] ram [0:3071];
	 integer i;
	 wire [31:0] LData;
	 wire [13:2] writeReg, readReg;
     wire [31:0] newWD;
	 wire [31:0] display_A;

	 assign writeReg = A[13:2];
	 assign readReg = A[13:2];
	 assign display_A = A & 32'hfffffffc;
	
	 LS_Control ls_control(.A(A), .RD(ram[readReg]), .BHExt(BHExt), .WD(WD), .LData(LData), .newWD(newWD));
	
	 // write ram
	 always @(posedge clk)
		begin
			if (reset == 1'b1)
				begin
					for (i = 0; i < 3072; i = i + 1)
						begin
							ram[i] <= 32'b0;
						end
				end
			else
				begin
					if (WE == 1'b1)
						begin
							if (BH == 1'b1)
							    begin
									ram[writeReg] <= newWD;
									$display("%d@%h: *%h <= %h", $time, pc, display_A, newWD); //display write
									//$display("@%h: *%h <= %h", pc, display_A, newWD); //display write
								end
							else 
								begin
									ram[writeReg] <= WD;
									$display("%d@%h: *%h <= %h", $time, pc, display_A, WD); //display write
									//$display("@%h: *%h <= %h", pc, display_A, WD); //display write
								end
						end
					else 
						begin
							ram[writeReg] <= ram[writeReg];
						end
				end
		end
	
	// read ram
	always @(*)
		begin
			if (BH == 1'b0)
				begin
					RD = ram[readReg];
				end
			else if (BH == 1'b1)
				begin
					RD = LData;
				end
			else 
				begin
					RD = ram[readReg];
				end

		end


endmodule


module LS_Control(
	input wire [31:0] A,
	input wire [31:0] RD,
	input wire [31:0] WD,
	input wire BHExt,
	output reg [31:0] newWD,
	output reg [31:0] LData
	);

	reg [7:0] byte_data;
	
	// readByte
	always @(*)
		begin
			if (A[1:0] == 2'b0)
				begin
					byte_data = RD[7:0];
				end
			else if (A[1:0] == 2'b1)
				begin
					byte_data = RD[15:8];
				end
			else if (A[1:0] == 2'b10)
				begin
					byte_data = RD[23:16];
				end
			else if (A[1:0] == 2'b11)
				begin
					byte_data = RD[31:24];
				end
		end
		
	// Byte Extend signal
	always @(*)
		begin
			if (BHExt == 1'b0)
				begin
					LData = { {24{byte_data[7]}}, byte_data };
				end
			else if (BHExt == 1'b1)
				begin
					LData = { {24{1'b0}}, byte_data };
				end
		end

	// shift WD into WByte according to A
	always @(*)
		begin
			if (A[1:0] == 2'b0)
			    begin
				    newWD = { {24{1'b0}}, WD[7:0] };
				end
			else if (A[1:0] == 2'b1)
				begin
					newWD = { {16{1'b0}}, WD[7:0], {8{1'b0}} };
				end
			else if (A[1:0] == 2'b10)
				begin
					newWD = { {8{1'b0}}, WD[7:0], {16{1'b0}} };
				end
			else if (A[1:0] == 2'b11)
				begin
					newWD = { WD[7:0], {24{1'b0}} };
				end
			else
				begin
					newWD = WD;
				end
		end
	
endmodule 

