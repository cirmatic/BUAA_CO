`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:05:23 10/29/2024 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input wire clk,
	input wire reset
    );

	/*********************F     area****************************/
	// IFU line
	wire [31:0] Instr_F, PC_F;
	wire [31:0] Next_PC_F;
	wire [31:0] PC_plus_4_F;
	wire EN_F;

	// ByPass line
    wire [31:0] Next_PC_D;
    wire [2:0] J_Op_D;
	wire If_Branch_D;

	assign PC_plus_4_F = PC_F + 32'b100;
	assign Next_PC_F = (J_Op_D == 3'b0 && If_Branch_D == 1'b0) ? PC_plus_4_F : Next_PC_D;

	IFU ifu(.clk(clk), .reset(reset), .Next_PC(Next_PC_F), .EN_F(EN_F),
		.PC(PC_F), .Instr(Instr_F));
	/*********************F     area****************************/
	wire [31:0] Instr_D;
	wire [31:0] PC_D;
	wire EN_D;

	FtoD f_to_d(.clk(clk), .reset(reset), .Instr_F2(Instr_F), .PC_F2(PC_F), .EN_D(EN_D),
		.Instr_D1(Instr_D), .PC_D1(PC_D));

	/*********************D     area****************************/
	// ByPass line
	wire [31:0] RegData_M;
	wire [2:0] ByPass_Rs_D, ByPass_Rt_D;
	// controlUnit line
	wire [5:0] opcode_D, funct_D;

	wire [2:0] Branch_Op_D, ALU_Op_D;
	wire BHExt_D, BH_D, RaLink_D, MemtoReg_D, ALUSrc_D, RegDst_D, RegWrite_D, MemWrite_D, SignedExt_D, Branch_D;
	// NPC line 
	wire [25:0] tarAddr_D;
	wire [31:0] offset_D;
	wire [31:0] j_Reg_D;

	wire [31:0] PC_plus_8_D;
	// GRF line
	wire [4:0] A1_D, A2_D;
	wire [4:0] A3_W;
	wire [31:0] WD_W, WPC_W;
	
	wire [31:0] RD1_D, RD2_D;
	// Extend line
	wire [15:0] imm_D;
	
	wire [31:0] out_imm_D;
	// WriteReg line
	wire [4:0] Rs_D, Rt_D, Rd_D;
	// Branch line
	wire [31:0] Branch_RD1_D, Branch_RD2_D;

	// controlUnit input
	assign opcode_D = Instr_D[31:26];
	assign funct_D = Instr_D[5:0];
	// GRF input
	assign A1_D = Instr_D[25:21];
	assign A2_D = Instr_D[20:16];
	// NPC input
	assign j_Reg_D = (ByPass_Rs_D == 3'b1) ? RegData_M : RD1_D;
	assign offset_D = out_imm_D;
	assign tarAddr_D = Instr_D[25:0];
	// Extend input
	assign imm_D = Instr_D[15:0];
	// WriteReg input
	assign Rs_D = Instr_D[25:21];
	assign Rt_D = Instr_D[20:16];
	assign Rd_D = Instr_D[15:11];
	// Branch input
	assign Branch_RD1_D = (ByPass_Rs_D == 3'b1) ? RegData_M : RD1_D;
	assign Branch_RD2_D = (ByPass_Rt_D == 3'b1) ? RegData_M : RD2_D;

	controlUnit controlunit(.opcode(opcode_D), .funct(funct_D),
		.BHExt(BHExt_D), .BH(BH_D), .RaLink(RaLink_D), .MemtoReg(MemtoReg_D), 	.ALUSrc(ALUSrc_D), 
		.RegDst(RegDst_D), .RegWrite(RegWrite_D), .MemWrite(MemWrite_D), .SignedExt(SignedExt_D), .Branch(Branch_D), 
		.J_Op(J_Op_D), .Branch_Op(Branch_Op_D), .ALU_Op(ALU_Op_D));

	NPC npc(.PC(PC_D), .J_Op(J_Op_D), .j_Reg(j_Reg_D), .If_Branch(If_Branch_D), .tarAddr(tarAddr_D), .offset(offset_D), 
	  .PC_plus_8(PC_plus_8_D), .Next_PC(Next_PC_D));

	Branch branch(.Branch(Branch_D), .RD1(Branch_RD1_D), .RD2(Branch_RD2_D), .Branch_Op(Branch_Op_D),
		.If_Branch(If_Branch_D));

	GRF grf(.A1(A1_D), .A2(A2_D), .A3(A3_W), .WD(WD_W), .WPC(WPC_W), .clk(clk), .reset(reset), .WE(RegWrite_W), 
		.RD1(RD1_D), .RD2(RD2_D));

	Extend extend(.imm(imm_D), .SignedExt(SignedExt_D), .out_imm(out_imm_D));
	/***********************D     area***************************/
	wire clr_E;
	wire [2:0] ALU_Op_E;
	wire [4:0] Rs_E, Rt_E, Rd_E;
	wire [31:0] RD1_E, RD2_E, Imm_E, PC_E, PC_plus_8_E;
	wire BHExt_E, BH_E, RaLink_E, MemtoReg_E, ALUSrc_E, RegDst_E, RegWrite_E, MemWrite_E, SignedExt_E, Branch_E;

	DtoE d_to_e(.clk(clk), .reset(reset), .clr_E(clr_E), .BHExt_D2(BHExt_D), .BH_D2(BH_D), .RaLink_D2(RaLink_D), .MemtoReg_D2(MemtoReg_D), .ALUSrc_D2(ALUSrc_D), .RegDst_D2(RegDst_D), .RegWrite_D2(RegWrite_D),
	 .MemWrite_D2(MemWrite_D), .ALU_Op_D2(ALU_Op_D), .RD1_D2(RD1_D), .RD2_D2(RD2_D), .Rs_D2(Rs_D), .Rt_D2(Rt_D), .Rd_D2(Rd_D), .Imm_D2(out_imm_D), .PC_D2(PC_D), .PC_plus_8_D2(PC_plus_8_D), 
			.BHExt_E1(BHExt_E), .BH_E1(BH_E), .RaLink_E1(RaLink_E), .MemtoReg_E1(MemtoReg_E), .ALUSrc_E1(ALUSrc_E), .RegDst_E1(RegDst_E), .RegWrite_E1(RegWrite_E), 
	.MemWrite_E1(MemWrite_E), .ALU_Op_E1(ALU_Op_E), .RD1_E1(RD1_E), .RD2_E1(RD2_E), .Rs_E1(Rs_E), .Rt_E1(Rt_E), .Rd_E1(Rd_E), .Imm_E1(Imm_E), .PC_E1(PC_E), .PC_plus_8_E1(PC_plus_8_E));

	/***********************E     area***************************/
	// E area line
	wire [4:0] WriteReg_E;
	wire [31:0] MemData_E;
	wire [2:0] ByPass_SrcA_E, ByPass_SrcB_E;
    wire [31:0] RegData_W;

	// ALU line
	wire [31:0] Src_A_E, Src_B_E;

	wire Zero;
	wire [31:0] ALUOut_E;

	// ALU input
	assign Src_A_E = (ByPass_SrcA_E == 3'b0) ? RD1_E : 
	                 (ByPass_SrcA_E == 3'b1) ? RegData_M : 
					 (ByPass_SrcA_E == 3'b10) ? RegData_W : RD1_E;
	assign Src_B_E = (ALUSrc_E == 1'b1) ? Imm_E :
	                 (ByPass_SrcB_E == 3'b0) ? RD2_E :
					 (ByPass_SrcB_E == 3'b1) ? RegData_M :
					 (ByPass_SrcB_E == 3'b10) ? RegData_W : RD2_E ;
    // MUX MemData
	assign MemData_E = (ByPass_SrcB_E == 3'b0) ? RD2_E :
					   (ByPass_SrcB_E == 3'b1) ? RegData_M :
					   (ByPass_SrcB_E == 3'b10) ? RegData_W : RD2_E ;
	// MUX WriteReg
    assign WriteReg_E = (RegDst_E == 1'b1) ? Rd_E : Rt_E;

	ALU alu(.Src_A(Src_A_E), .Src_B(Src_B_E), .ALU_OP(ALU_Op_E), .ALUOut(ALUOut_E));
	/************************E     area****************************/
    wire BHExt_M;   
    wire BH_M; 
    wire RaLink_M;  
    wire MemtoReg_M; 
    wire RegWrite_M; 
    wire MemWrite_M;
    wire [31:0] ALUOut_M; 
    wire [31:0] MemData_M;  
    wire [4:0] WriteReg_temp_M; 
	wire [31:0] PC_M;
	wire [31:0] PC_plus_8_M;
 

	EtoM e_to_m(.clk(clk), .reset(reset), .BHExt_E2(BHExt_E), .BH_E2(BH_E), .RaLink_E2(RaLink_E), .MemtoReg_E2(MemtoReg_E), .RegWrite_E2(RegWrite_E), 
	.MemWrite_E2(MemWrite_E), .ALUOut_E2(ALUOut_E), .MemData_E2(MemData_E), .WriteReg_E2(WriteReg_E), .PC_E2(PC_E), .PC_plus_8_E2(PC_plus_8_E),
			.BHExt_M1(BHExt_M), .BH_M1(BH_M), .RaLink_M1(RaLink_M), .MemtoReg_M1(MemtoReg_M), .RegWrite_M1(RegWrite_M), 
	.MemWrite_M1(MemWrite_M), .ALUOut_M1(ALUOut_M), .MemData_M1(MemData_M), .WriteReg_M1(WriteReg_temp_M), .PC_M1(PC_M), .PC_plus_8_M1(PC_plus_8_M));

	/************************M     area****************************/
	// M area line
	wire [4:0] WriteReg_M;

	assign WriteReg_M = (RaLink_M == 1'b1) ? 5'h1f : WriteReg_temp_M;
	// DM line 
	wire [31:0] Addr_M;

	wire [31:0] ReadData_M;

    // DM input
	assign Addr_M = ALUOut_M;

	assign RegData_M = (RaLink_M == 1'b1) ? PC_plus_8_M : ALUOut_M;

	DM dm(.clk(clk), .reset(reset), .A(Addr_M), .WD(MemData_M), .pc(PC_M), .BH(BH_M), .BHExt(BHExt_M), .WE(MemWrite_M),  
		.RD(ReadData_M));
	/*************************M    area****************************/
    wire RaLink_W;
    wire MemtoReg_W;
    wire RegWrite_W;
    wire [31:0] ReadData_W;
    wire [31:0] ALUOut_W;
    wire [4:0] WriteReg_W;
	wire [31:0] PC_W;
	wire [31:0] PC_plus_8_W;
	wire [31:0] RegData_temp_W;

	MtoW m_to_w(.clk(clk), .reset(reset), .MemtoReg_M2(MemtoReg_M), .RegWrite_M2(RegWrite_M), .ReadData_M2(ReadData_M), 
	.ALUOut_M2(ALUOut_M), .WriteReg_M2(WriteReg_M), .PC_M2(PC_M), .PC_plus_8_M2(PC_plus_8_M), .RegData_M2(RegData_M),
	        .MemtoReg_W1(MemtoReg_W), .RegWrite_W1(RegWrite_W), .ReadData_W1(ReadData_W), .ALUOut_W1(ALUOut_W), 
	.WriteReg_W1(WriteReg_W), .PC_W1(PC_W), .PC_plus_8_W1(PC_plus_8_W), .RegData_W1(RegData_temp_W));

	/*************************W    area****************************/
    // W area line
	assign RegData_W = (MemtoReg_W == 1'b1) ? ReadData_W : RegData_temp_W;
	 // GRF write line

	assign A3_W = WriteReg_W;
	assign WD_W = RegData_W;
	assign WPC_W = PC_W;

	/*************************W    area****************************/

	// Conflict Unit
	Conflict conflict(.Branch_D(Branch_D), .J_Op_D(J_Op_D), .Rs_D(Rs_D), .Rt_D(Rt_D), 
	.Rs_E(Rs_E), .Rt_E(Rt_E), .RegWrite_E(RegWrite_E), .MemtoReg_E(MemtoReg_E), .WriteReg_E(WriteReg_E),
	.MemtoReg_M(MemtoReg_M),  .RegWrite_M(RegWrite_M), .WriteReg_M(WriteReg_M), .WriteReg_W(WriteReg_W), .RegWrite_W(RegWrite_W),
			.ByPass_Rs_D(ByPass_Rs_D), .ByPass_Rt_D(ByPass_Rt_D), .ByPass_SrcA_E(ByPass_SrcA_E), .ByPass_SrcB_E(ByPass_SrcB_E), .EN_F(EN_F), .EN_D(EN_D), .clr_E(clr_E));

endmodule

