`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:43 11/05/2024 
// Design Name: 
// Module Name:    D 
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
module FtoD(
    input wire clk,
    input wire reset,
    input wire [31:0] Instr_F2,
    input wire [31:0] PC_F2,
    input wire EN_D,

    output wire [31:0] Instr_D1,
    output wire [31:0] PC_D1 	
    );

    reg [31:0] Instr;
    reg [31:0] PC;

    assign Instr_D1 = Instr;
    assign PC_D1 = PC;

    always @(posedge clk)
        begin
            if (reset == 1'b1)
                begin
                    Instr <= 32'b0;
                    PC <= 32'b0;
                end
            else if (EN_D == 1'b1)
                begin
                    Instr <= Instr_F2;
                    PC <= PC_F2;
                end
            else 
                begin
                    Instr <= Instr;
                    PC <= PC;
                end
        end
endmodule
