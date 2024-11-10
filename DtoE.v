`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:53 11/05/2024 
// Design Name: 
// Module Name:    DtoE 
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
module DtoE(
    input wire clk,
    input wire reset,
    input wire clr_E,
    input wire BHExt_D2,
    input wire BH_D2,
    input wire RaLink_D2,
    input wire MemtoReg_D2,
    input wire ALUSrc_D2,
    input wire RegDst_D2,
    input wire RegWrite_D2,
    input wire MemWrite_D2,
    input wire [2:0] ALU_Op_D2,
    input wire [31:0] RD1_D2,
    input wire [31:0] RD2_D2,
    input wire [4:0] Rs_D2,
    input wire [4:0] Rt_D2,
    input wire [4:0] Rd_D2,
    input wire [31:0] Imm_D2,
    input wire [31:0] PC_plus_8_D2,
    input wire [31:0] PC_D2,

    output wire BHExt_E1,
    output wire BH_E1,
    output wire RaLink_E1, 
    output wire MemtoReg_E1,
    output wire ALUSrc_E1,
    output wire RegDst_E1,
    output wire RegWrite_E1,
    output wire MemWrite_E1,
    output wire [2:0] ALU_Op_E1,
    output wire [31:0] RD1_E1,
    output wire [31:0] RD2_E1,
    output wire [4:0] Rs_E1,
    output wire [4:0] Rt_E1,
    output wire [4:0] Rd_E1,
    output wire [31:0] Imm_E1,
    output wire [31:0] PC_plus_8_E1,
    output wire [31:0] PC_E1
    );


    reg BHExt;
    reg BH;
    reg RaLink;
    reg MemtoReg;
    reg ALUSrc;
    reg RegDst;
    reg RegWrite;
    reg MemWrite;
    reg [2:0] ALU_Op;
    reg [31:0] RD1;
    reg [31:0] RD2;
    reg [4:0] Rs;
    reg [4:0] Rt;
    reg [4:0] Rd;
    reg [31:0] Imm;
    reg [31:0] PC_plus_8;
    reg [31:0] PC;

    assign BHExt_E1 = BHExt;
    assign BH_E1 = BH;
    assign RaLink_E1 = RaLink;
    assign MemtoReg_E1 = MemtoReg;
    assign ALUSrc_E1 = ALUSrc;
    assign RegDst_E1 = RegDst;
    assign RegWrite_E1 = RegWrite;
    assign MemWrite_E1 = MemWrite;
    assign ALU_Op_E1 = ALU_Op;
    assign RD1_E1 = RD1; 
    assign RD2_E1 = RD2;
    assign Rs_E1 = Rs;
    assign Rt_E1 = Rt;
    assign Rd_E1 = Rd;
    assign Imm_E1 = Imm;
    assign PC_plus_8_E1 = PC_plus_8;
    assign PC_E1 = PC;

    always @(posedge clk) 
        begin
            if (reset == 1'b1)
                begin
                    BHExt <= 1'b0;
                    BH <= 1'b0;
                    RaLink <= 1'b0;
                    MemtoReg <= 1'b0;
                    ALUSrc <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    ALU_Op <= 3'b0;
                    RD1 <= 32'b0;
                    RD2 <= 32'b0;
                    Rs <= 5'b0;
                    Rt <= 5'b0;
                    Rd <= 5'b0;
                    Imm <= 32'b0;
                    PC_plus_8 <= 32'b0;
                    PC <= 32'b0;
                end
            else if (clr_E == 1'b1)
                begin
                    BHExt <= 1'b0;
                    BH <= 1'b0;
                    RaLink <= 1'b0;
                    MemtoReg <= 1'b0;
                    ALUSrc <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    ALU_Op <= 3'b0;
                    RD1 <= 32'b0;
                    RD2 <= 32'b0;
                    Rs <= 5'b0;
                    Rt <= 5'b0;
                    Rd <= 5'b0;
                    Imm <= 32'b0;
                    PC_plus_8 <= 32'b0;
                    PC <= 32'b0;
                end
            else 
                begin
                    BHExt <= BHExt_D2;
                    BH <= BH_D2;
                    RaLink <= RaLink_D2;
                    MemtoReg <= MemtoReg_D2;
                    ALUSrc <= ALUSrc_D2;
                    RegDst <= RegDst_D2;
                    RegWrite <= RegWrite_D2;
                    MemWrite <= MemWrite_D2;
                    ALU_Op <= ALU_Op_D2;
                    RD1 <= RD1_D2;
                    RD2 <= RD2_D2; 
                    Rs <= Rs_D2;
                    Rt <= Rt_D2;
                    Rd <= Rd_D2;
                    Imm <= Imm_D2;
                    PC_plus_8 <= PC_plus_8_D2;
                    PC <= PC_D2;
                end
        end

endmodule
