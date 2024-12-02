`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:27 10/29/2024 
// Design Name: 
// Module Name:    NPC 
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
module NPC(	
	input wire [31:0] PC,
	input wire [31:0] offset,
	input wire If_Branch,
	input wire [25:0] tarAddr,
	input wire [31:0] j_Reg,
	input wire [2:0] J_Op,

	output wire [31:0] PC_plus_8,
	output reg [31:0] Next_PC
    );
	 
	wire [31:0] Branch_Addr, J_Addr;
	 
	 // calculate j/b addr
	 assign Branch_Addr = (offset << 2'b10) + PC + 32'b100;
	 assign J_Addr = { PC[31:28], tarAddr, {2{1'b0}} };
	 
	 // PC_plus_8 
	 assign PC_plus_8 = PC + 32'b1000;
	 
	 // Next_PC 
	 always @(*)
		begin
			if (J_Op == 3'b0)
				begin
					if (If_Branch == 1'b1)
						begin
							Next_PC = Branch_Addr;
						end
					else 
						begin
							Next_PC = PC + 32'b1000;
						end
				end
			else if (J_Op == 3'b1)
				begin
					Next_PC = J_Addr;
				end
			else if (J_Op == 3'b10)
				begin
					Next_PC = J_Addr;
				end
			else if (J_Op == 3'b11)
				begin
					Next_PC = j_Reg;
				end
			else 
				begin
					Next_PC = PC + 32'b1000;
				end
		end
endmodule

