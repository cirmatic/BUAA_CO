`timescale 1ns / 1ps
`default_nettype none

`define Original_Data 3'b0
`define M_Data 3'b1
`define W_Data 3'b10
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:09 11/07/2024 
// Design Name: 
// Module Name:    Conflict 
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
module Conflict(
    input wire Branch_D,
    input wire [2:0] J_Op_D,
    input wire [4:0] Rs_D,
    input wire [4:0] Rt_D,

    input wire [4:0] Rs_E,
    input wire [4:0] Rt_E,
    input wire RegWrite_E,
    input wire MemtoReg_E,
    input wire [4:0] WriteReg_E,

    input wire MemtoReg_M,
    input wire RegWrite_M,
    input wire [4:0] WriteReg_M,

    input wire [4:0] WriteReg_W,
    input wire RegWrite_W,

    output reg [2:0] ByPass_Rs_D,
    output reg [2:0] ByPass_Rt_D, 

    output reg [2:0] ByPass_SrcA_E,
    output reg [2:0] ByPass_SrcB_E,

    output reg EN_F,
    output reg EN_D,
    output reg clr_E
    );

    // load and Branch and jr nop
    always @(*)
        begin
            if (MemtoReg_E == 1'b1 && WriteReg_E != 5'b0 && (Rs_D == WriteReg_E || Rt_D == WriteReg_E)) // E is lw and hazard
                begin
                    EN_F = 1'b0;
                    EN_D = 1'b0;
                    clr_E = 1'b1;
                end
            else if (Branch_D == 1'b1 && RegWrite_E == 1'b1 && WriteReg_E != 5'b0 && (Rs_D == WriteReg_E || Rt_D == WriteReg_E) ) //Branch and E is ALU
                begin
                    EN_F = 1'b0;
                    EN_D = 1'b0;
                    clr_E = 1'b1;
                end
            else if (Branch_D == 1'b1 && MemtoReg_M == 1'b1 && WriteReg_M != 5'b0 && (Rs_D == WriteReg_M || Rt_D == WriteReg_M)) // Branch and M is lw
                begin
                    EN_F = 1'b0;
                    EN_D = 1'b0;
                    clr_E = 1'b1;
                end
            else if (J_Op_D == 3'b11 && RegWrite_E == 1'b1 && WriteReg_E != 5'b0 && Rs_D == WriteReg_E) // jr and E is ALU
                begin
                    EN_F = 1'b0;
                    EN_D = 1'b0;
                    clr_E = 1'b1;
                end
            else if (J_Op_D == 3'b11 && MemtoReg_M == 1'b1 && WriteReg_M != 5'b0 && Rs_D == WriteReg_M) // jr and M is lw
                begin
                    EN_F = 1'b0;
                    EN_D = 1'b0;
                    clr_E = 1'b1;
                end
            else 
                begin
                    EN_F = 1'b1;
                    EN_D = 1'b1;
                    clr_E = 1'b0;
                end
        end

    // Src_A_E choosing
    always @(*)
        begin
            if (Rs_E != 5'b0 && Rs_E == WriteReg_M && RegWrite_M == 1'b1)
                begin
                    ByPass_SrcA_E = `M_Data; 
                end
            else if (Rs_E != 5'b0 && Rs_E == WriteReg_W && RegWrite_W == 1'b1)
                begin
                    ByPass_SrcA_E = `W_Data;
                end
            else 
                begin
                    ByPass_SrcA_E = `Original_Data;
                end
        end

    // Src_B_E and MemData choosing
    always @(*)
        begin
            if (Rt_E != 5'b0 && Rt_E == WriteReg_M && RegWrite_M == 1'b1)
                begin
                    ByPass_SrcB_E = `M_Data;
                end
            else if (Rt_E != 5'b0 && Rt_E == WriteReg_W && RegWrite_W == 1'b1)
                begin
                    ByPass_SrcB_E = `W_Data;
                end
            else 
                begin
                    ByPass_SrcB_E = `Original_Data;
                end
        end

    // Rs_D: Branch and jr choosing
    always @(*)
        begin
            if (RegWrite_M == 1'b1 && Rs_D != 5'b0 && WriteReg_M == Rs_D)
                begin
                    ByPass_Rs_D = `M_Data;
                end
            else 
                begin
                    ByPass_Rs_D = `Original_Data;
                end
        end

    // Rt_D: Branch and jr chossing
    always @(*)
        begin
            if (RegWrite_M == 1'b1 && Rt_D != 5'b0 && WriteReg_M == Rt_D)
                begin
                    ByPass_Rt_D = `M_Data;
                end
            else 
                begin
                    ByPass_Rt_D = `Original_Data;
                end

        end

endmodule
