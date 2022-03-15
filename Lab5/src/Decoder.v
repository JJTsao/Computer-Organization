//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    	instr_op_i,
				//instr_fun_i,
	RegWrite_o, //for WB
	ALU_op_o, //for EX
	ALUSrc_o, //for EX
	RegDst_o, //for EX
	Branch_o, //for M
	MemToReg_o, //for WB
				//BranchType_o, 
				//Jump_o,
	MemRead_o, //for M
	MemWrite_o //for M
				//JumpToReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
				//input  [6-1:0] instr_fun_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output	       RegDst_o;
output         Branch_o;
output	       MemToReg_o;
				//output	[2-1:0] BranchType_o;
				//output		Jump_o;
output		MemRead_o;
output		MemWrite_o;
				//output		JumpToReg_o;
//Internal Signals

reg            RegWrite_o;
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg	       RegDst_o;
reg            Branch_o;
reg	       MemToReg_o;
				//reg	[2-1:0] BranchType_o;
				//reg		Jump_o;
reg		MemRead_o;
reg		MemWrite_o;
				//reg		JumpToReg_o;
//Parameter

// addi    001000
// sw      101011
// lw      100011
// R-type  000000
// beq     000100

//Main function
always@(*)
begin
	case(instr_op_i)
		6'b000000 : begin //R-type
				Branch_o <= 0; MemToReg_o <= 1;
			    	MemRead_o <= 0; MemWrite_o <= 0;
				ALU_op_o <= 3'b010; ALUSrc_o <= 0;
				RegWrite_o <= 1; RegDst_o <= 1;
			    end
		6'b001000 : begin //addi
			    	Branch_o <= 0; MemToReg_o <= 1;
			    	MemRead_o <= 0; MemWrite_o <= 0;
			    	ALU_op_o <= 3'b100; ALUSrc_o <= 1;
			    	RegWrite_o <= 1; RegDst_o <= 0;
			    end
		6'b100011 : begin //lw
			    Branch_o <= 0; MemToReg_o <= 0;
			    MemRead_o <= 1; MemWrite_o <= 0;
			    ALU_op_o <= 3'b000; ALUSrc_o <= 1;
			    RegWrite_o <= 1; RegDst_o <= 0;
			    end
		6'b101011 : begin //sw
			    Branch_o <= 0; MemToReg_o <= 0;
			    MemRead_o <= 0; MemWrite_o <= 1;
			    ALU_op_o <= 3'b000; ALUSrc_o <= 1;
			    RegWrite_o <= 0; RegDst_o <= 0;	
			    end
		6'b000100 : begin //beq
			    Branch_o <= 1; MemToReg_o <= 0;
			    MemRead_o <= 0; MemWrite_o <= 0;
			    ALU_op_o <= 3'b001; ALUSrc_o <= 0;
			    RegWrite_o <= 0; RegDst_o <= 0;	
			    end
	endcase
end
endmodule





                    
                    