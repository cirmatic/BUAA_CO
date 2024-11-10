`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:24 10/29/2024 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	input wire [4:0] A1,
	input wire [4:0] A2,
	input wire [4:0] A3,
	input wire [31:0] WD,
	input wire clk,
	input wire reset,
	input wire WE,
	input wire [31:0] WPC,
	output wire [31:0] RD1,
	output wire [31:0] RD2
	);

	// define reg group
	reg [31:0] register [0:31];
	integer i;
	
	// connect output
	assign RD1 = register[A1];
	assign RD2 = register[A2];
	
	// write reg
	always @(negedge clk)
		begin
			if(reset == 1'b1)
				begin				
					for (i = 0; i < 32; i = i + 1)
						begin
							register[i] <= 32'b0;
						end
				end
			else 
				begin
					if (WE == 1'b1)
						begin
							if (A3 == 5'b0) 
							    begin
									register[A3] <= 32'b0;
								end
							else 
								begin
									register[A3] <= WD;
								end
							$display("%d@%h: $%d <= %h", $time, WPC, A3, WD);	// display addr & value
							//$display("@%h: $%d <= %h", WPC, A3, WD);
						end
					else 
						begin
							register[A3] <= register[A3];
						end
				end
		end

endmodule

