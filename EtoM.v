`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:08 11/05/2024 
// Design Name: 
// Module Name:    EtoM 
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
module EtoM(
    input wire clk,
    input wire reset,
    input wire BHExt_E2,  
    input wire BH_E2,    
    input wire RaLink_E2,  
    input wire MemtoReg_E2, 
    input wire RegWrite_E2, 
    input wire MemWrite_E2, 
    input wire [31:0] ALUOut_E2,  
    input wire [31:0] MemData_E2, 
    input wire [4:0] WriteReg_E2,
    input wire [31:0] PC_E2,
    input wire [31:0] PC_plus_8_E2,

    output wire BHExt_M1,   
    output wire BH_M1,    
    output wire RaLink_M1,  
    output wire MemtoReg_M1, 
    output wire RegWrite_M1, 
    output wire MemWrite_M1, 
    output wire [31:0] ALUOut_M1,  
    output wire [31:0] MemData_M1,  
    output wire [4:0] WriteReg_M1,
    output wire [31:0] PC_M1,
    output wire [31:0] PC_plus_8_M1 
    );

    reg BHExt;
    reg BH;
    reg RaLink;
    reg MemtoReg;
    reg RegWrite;
    reg MemWrite;
    reg [31:0] ALUOut;
    reg [31:0] MemData; 
    reg [4:0] WriteReg;
    reg [31:0] PC;
    reg [31:0] PC_plus_8;

    assign BHExt_M1 = BHExt; 
    assign BH_M1 = BH; 
    assign RaLink_M1 = RaLink;   
    assign MemtoReg_M1 =  MemtoReg;
    assign RegWrite_M1 =  RegWrite;
    assign MemWrite_M1 =  MemWrite;
    assign ALUOut_M1 = ALUOut; 
    assign MemData_M1 = MemData; 
    assign WriteReg_M1 = WriteReg;
    assign PC_M1 = PC;
    assign PC_plus_8_M1 = PC_plus_8;

    always @(posedge clk) 
        begin
            if (reset == 1'b1)
                begin
                    BHExt <= 1'b0;
                    BH <= 1'b0;
                    RaLink <= 1'b0;
                    MemtoReg <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    ALUOut <= 32'b0;
                    MemData <= 32'b0; 
                    WriteReg <= 5'b0;
                    PC <= 32'b0;
                    PC_plus_8 <= 32'b0;
                end
            else 
                begin
                    BHExt <= BHExt_E2;
                    BH <= BH_E2;
                    RaLink <= RaLink_E2;
                    MemtoReg <= MemtoReg_E2;
                    RegWrite <= RegWrite_E2;
                    MemWrite <= MemWrite_E2;
                    ALUOut <= ALUOut_E2;
                    MemData <= MemData_E2; 
                    WriteReg <= WriteReg_E2;
                    PC <= PC_E2;
                    PC_plus_8 <= PC_plus_8_E2;
                end
        end

endmodule
