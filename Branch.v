`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:36 10/30/2024 
// Design Name: 
// Module Name:    Branch 
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
module Branch(
	input wire Branch,
	input wire [31:0] RD1,
	input wire [31:0] RD2,
	input wire [2:0] Branch_Op,
	output reg If_Branch // directly decide branch
    );

	reg Zero;

	always @(*)
		begin
			if (Branch_Op == 3'b0)
				begin
					If_Branch = 1'b0;
				end
			else if (Branch_Op == 3'b1)
				begin
					Zero = (RD1 == RD2);
					If_Branch = Branch & Zero;
				end
			else if (Branch_Op == 3'b10)
				begin
					Zero = (RD1 != RD2);
					If_Branch = Branch & Zero;
				end
			else if (Branch_Op == 3'b11)
				begin
					Zero = (RD1 > 32'b0);
					If_Branch = Branch & Zero;
				end
			else if (Branch_Op == 3'b100)
				begin
					Zero = ($signed(RD1) >= $signed(0));
					If_Branch = Branch & Zero;
				end
			else 
				begin
					If_Branch = 1'b0;
				end
		end

endmodule

