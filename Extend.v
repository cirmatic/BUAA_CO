`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:41:12 10/30/2024 
// Design Name: 
// Module Name:    Extend 
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
module Extend(
	input wire [15:0] imm,
	input wire SignedExt,
	output reg [31:0] out_imm
    );
	
	always @(*)
		begin
			if (SignedExt == 1'b0)
				begin
					out_imm = { {16{1'b0}}, imm };
				end
			else if (SignedExt == 1'b1)
				begin
					out_imm = { {16{imm[15]}}, imm };
				end
			else 
				begin
					out_imm = { {16{1'b0}}, imm };
				end
		end

endmodule

