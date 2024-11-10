`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:06 10/29/2024 
// Design Name: 
// Module Name:    IM 
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
module IFU(
	input wire [31:0] Next_PC,
	input wire clk,
	input wire reset,
	input wire EN_F,
	output wire [31:0] Instr,
	output wire [31:0] PC
    );
	
	// im definition
	reg [31:0] im [0:4095];
	
	// temp var
	wire [31:0] Now_PC;
	wire [31:0] temp;
	wire [23:0] Addr;

	initial begin
		//$readmemh("E:\\verilog\\p5\\code.txt", im);
		$readmemh("code.txt", im);
	end

	// PC module
	PC pc(.Next_PC(Next_PC), .clk(clk), .reset(reset), .EN_F(EN_F), 
	      .Now_PC(Now_PC));
	
	// output
	assign PC = Now_PC;
	assign temp = ((Now_PC - 32'h3000) >> 2'b10);
	assign Addr = temp[23:0];
	assign Instr = im[Addr];
	
endmodule

module PC(
	input wire [31:0] Next_PC,
	input wire clk,
	input wire reset,
	input wire EN_F,
	output wire [31:0] Now_PC
	);
	
	reg [31:0] reg_pc = 32'b0;
	
	assign Now_PC = (reg_pc == 32'b0) ? 32'h3000 : reg_pc;
	
	always @(posedge clk)
		begin
			if (reset == 1'b1)
				begin
					reg_pc <= 32'b0;
				end
			else if (EN_F == 1'b0)
				begin
					reg_pc <= reg_pc;
				end
			else 
				begin
					reg_pc <= Next_PC;
				end
		end
		
endmodule
