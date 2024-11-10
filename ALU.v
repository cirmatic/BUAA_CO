`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:38:01 10/30/2024 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input wire [31:0] Src_A,
	input wire [31:0] Src_B,
	input wire [2:0] ALU_OP,
	output reg [31:0] ALUOut
    );
	
	// calculate Result
	always @(*)
		begin
			if (ALU_OP == 3'b0)
				begin
					ALUOut = Src_A + Src_B;
				end
			else if (ALU_OP == 3'b1)
				begin
					ALUOut = Src_A - Src_B;
				end
			else if (ALU_OP == 3'b10)
				begin
					ALUOut = Src_A | Src_B;
				end
			else if (ALU_OP == 3'b11)
				begin
					ALUOut = Src_B << 5'h10;
				end
			else 
				begin
					ALUOut = Src_A + Src_B;
				end
		end

endmodule

