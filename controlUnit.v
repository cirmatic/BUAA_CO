`timescale 1ns / 1ps
`default_nettype none

`define add 6'b100000
`define sub 6'b100010
`define jr  6'b001000
`define ori 6'b001101
`define lui 6'b001111
`define j   6'b000010
`define jal 6'b000011
`define lw  6'b100011
`define sw  6'b101011
`define lb  6'b100000
`define lbu 6'b100100
`define beq 6'b000100
`define bne 6'b000101
`define bgtz 6'b000111
`define sb  6'b101000
`define bgezall 6'b111000
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:47 10/29/2024 
// Design Name: 
// Module Name:    controlUnit 
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
module controlUnit(
	input wire [31:26] opcode,
	input wire [5:0] funct,
	
	output wire BHExt,
	output wire BH, 
	output wire RaLink, 
	output wire MemtoReg, 
	output wire ALUSrc, 
	output wire RegDst,	
	output wire RegWrite, 
	output wire MemWrite, 
	output wire SignedExt, 
	output wire Branch,
	output wire Bgezall, 
	output reg [2:0] J_Op,
	output reg [2:0] Branch_Op,
	output reg [2:0] ALU_Op
    );

	// var
	wire add, sub, ori, lui, j, jal, jr, lw, sw, beq, bne, lb, lbu, sb, bgtz, bgezall;

	// output assign
	assign BHExt = lbu;
	assign BH = lbu | lb | sb;
	assign RaLink = jal | bgezall;
	assign MemtoReg = lbu | lb | lw;
	assign ALUSrc = lbu | lb | sb | sw | lw | lui | ori;
	assign RegDst = add | sub;
	assign RegWrite = lbu | lb | lw | jal | lui | ori | add | sub | bgezall;
	assign MemWrite = sw | sb;
	assign SignedExt = lbu | lb | sb | bne | beq | sw | lw | bgtz | bgezall;
	assign Branch = bne | beq | bgtz | bgezall;
	assign Bgezall = bgezall;
	
	// J_Op
	always @(*)
		begin
			if (j == 1'b1)
				begin
					J_Op = 3'b1;
				end
			else if (jal == 1'b1)
				begin
					J_Op = 3'b10;
				end
			else if (jr == 1'b1)
				begin
					J_Op = 3'b11;
				end
			else 
				begin
					J_Op = 3'b0;
				end
		end
	
	// ALU_Op
	always @(*)
		begin
			if (add == 1'b1)
				begin
					ALU_Op = 3'b0;
				end
			else if (sub == 1'b1)
				begin
					ALU_Op = 3'b1;
				end
			else if (ori == 1'b1)
				begin
					ALU_Op = 3'b10;
				end
			else if (lui == 1'b1)
				begin
					ALU_Op =3'b11;
				end
			else 
				begin
					ALU_Op = 3'b0;
				end
		end
		
	// Branch_Op
	always @(*)
		begin
			if (beq == 1'b1)
				begin
					Branch_Op = 3'b1;
				end
			else if (bne == 1'b1)
				begin
					Branch_Op = 3'b10;
				end
			else if (bgtz == 1'b1)
				begin
					Branch_Op = 3'b11;
				end
			else if (bgezall == 1'b1)
				begin
					Branch_Op = 3'b100;
				end
			else 
				begin
					Branch_Op = 3'b0;
				end
		end
		
	// recognize operation
	assign add = (opcode == 6'b000000) && (funct == `add);
	assign sub = (opcode == 6'b000000) && (funct == `sub);
	assign jr  = (opcode == 6'b000000) && (funct == `jr);
	assign ori = (opcode == `ori);
	assign lui = (opcode == `lui);
	assign j   = (opcode == `j);
	assign jal = (opcode == `jal);
	assign lw  = (opcode == `lw);
	assign sw  = (opcode == `sw);
	assign beq = (opcode == `beq);
	assign bne = (opcode == `bne);
	assign bgtz = (opcode == `bgtz);
	assign lb  = (opcode == `lb);
	assign lbu = (opcode == `lbu);
	assign sb  = (opcode == `sb);
	assign bgezall = (opcode == `bgezall);

endmodule

