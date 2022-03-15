//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//ALUOP :
//R-type	010
//addi		100
//lw,sw		000
//beq		001
//Parameter

       
//Select exact operation
always@(*)
begin
	if(ALUOp_i == 3'b010)
	begin
		case(funct_i)
			6'b100000 : ALUCtrl_o <= 4'b0010; //add
			6'b100101 : ALUCtrl_o <= 4'b0001; //or
			6'b100100 : ALUCtrl_o <= 4'b0000; //and
			6'b100010 : ALUCtrl_o <= 4'b0110; //sub
			6'b101010 : ALUCtrl_o <= 4'b0111; //slt
			6'b011000 : ALUCtrl_o <= 4'b0101; //mult
		endcase
	end
	else if(ALUOp_i == 3'b001)
		ALUCtrl_o <= 4'b0110;
	else
		ALUCtrl_o <= 4'b0010;
end
endmodule     





                    
                    