`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:18 11/05/2024 
// Design Name: 
// Module Name:    MtoW 
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
module MtoW(
    input wire clk,
    input wire reset,
    input wire clr_W,
    input wire MemtoReg_M2,
    input wire RegWrite_M2,
    input wire [31:0] ReadData_M2,
    input wire [4:0] WriteReg_M2,
    input wire [31:0] PC_M2,
    input wire [31:0] RegData_M2,

    output wire MemtoReg_W1,
    output wire RegWrite_W1,
    output wire [31:0] ReadData_W1,
    output wire [4:0] WriteReg_W1,
    output wire [31:0] PC_W1,
    output wire [31:0] RegData_W1
    );

    reg MemtoReg;
    reg RegWrite;
    reg [31:0] ReadData;
    reg [4:0] WriteReg;
    reg [31:0] PC;
    reg [31:0] RegData;


    assign MemtoReg_W1 = MemtoReg;
    assign RegWrite_W1 = RegWrite;
    assign ReadData_W1 = ReadData;
    assign WriteReg_W1 = WriteReg;
    assign PC_W1 = PC;
    assign RegData_W1 = RegData;

    always @(posedge clk)
        begin
            if (reset == 1'b1)
                begin
                    MemtoReg <= 1'b0;
                    RegWrite <= 1'b0;
                    ReadData <= 32'b0;
                    WriteReg <= 5'b0;
                    PC <= 32'b0;
                    RegData <= 32'b0;
                end
            else if (clr_W == 1'b1)
                begin
                    MemtoReg <= 1'b0;
                    RegWrite <= 1'b0;
                    ReadData <= 32'b0;
                    WriteReg <= 5'b0;
                    PC <= 32'b0;
                    RegData <= 32'b0;
                end
            else 
                begin
                    MemtoReg <= MemtoReg_M2;
                    RegWrite <= RegWrite_M2;
                    ReadData <= ReadData_M2;
                    WriteReg <= WriteReg_M2;
                    PC <= PC_M2;
                    RegData <= RegData_M2;
                end
       end

endmodule
