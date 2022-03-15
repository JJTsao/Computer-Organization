//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
//reg    [3-1:0] ALU_op_o;
//reg            ALUSrc_o;
//reg            RegWrite_o;
//reg            RegDst_o;
//reg            Branch_o;

//Parameter

//R-Type: 000000
//addi: 001000
//slti: 001010
//beq: 000100
//Main function

	/*case(instr_op_i)
	6'b000000 : ALU_op_o <= 3'b010; ALUSrc_o <= 0; RegWrite_o <= 1; 
			RegDst_o <= 1; Branch_o <= 0;//R-Type
	6'b001000 : ALU_op_o <= 3'b100; ALUSrc_o <= 1; RegWrite_o <= 1; 
			RegDst_o <= 0; Branch_o <= 1;//addi
	6'b001010 : ALU_op_o <= 3'b101; ALUSrc_o <= 1; RegWrite_o <= 1; 
			RegDst_o <= 0; Branch_o <= 0;//slti
	6'b000100 : ALU_op_o <= 3'b110; ALUSrc_o <= 0; RegWrite_o <= 0; 
			RegDst_o <= 0; Branch_o <= 0;//beq
	endcase*/
assign ALU_op_o = (instr_op_i == 6'b000000 ) ? 3'b010 :
		  (instr_op_i == 6'b001000 ) ? 3'b100 :
		  (instr_op_i == 6'b001010 ) ? 3'b101 : 3'b110 ;
assign ALUSrc_o = (instr_op_i == 6'b000000 ) ? 0 :
		  (instr_op_i == 6'b001000 ) ? 1 :
		  (instr_op_i == 6'b001010 ) ? 1 : 0 ;
assign RegWrite_o = (instr_op_i == 6'b000000 ) ? 1 :
		    (instr_op_i == 6'b001000 ) ? 1 :
		    (instr_op_i == 6'b001010 ) ? 1 : 0;
assign RegDst_o = (instr_op_i == 6'b000000 ) ? 1 : 0;
assign Branch_o = (instr_op_i == 6'b000100 ) ? 1 : 0;
endmodule





                    
                    