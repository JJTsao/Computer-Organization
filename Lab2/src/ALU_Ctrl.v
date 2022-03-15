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

//Parameter
//ALUOp of R-Type: 010  //ALUCtrl=0 for and
//ALUOp of addi: 100	//ALUCtrl=1 for or
//ALUOp of slti: 101	//ALUCtrl=2 for add
//ALUOp of beq: 110	//ALUCtrl=6 for sub
			//ALUCtrl=7 for slt
			//ALUCtrl=12 for nor
//Select exact operation
always@(*)
begin
	ALUCtrl_o <= 4'b0000;
	if(ALUOp_i != 3'b010)
	begin
		case(ALUOp_i)
			3'b100: ALUCtrl_o <= 4'b0010; //addi
			3'b101: ALUCtrl_o <= 4'b0111; //slt
			3'b110: ALUCtrl_o <= 4'b0110; //beq to ctrl=>sub
			default: ALUCtrl_o <= 4'b1000;
		endcase
	end
	else
	begin
		case(funct_i)
			6'b100000: ALUCtrl_o <= 4'b0010; //add
			6'b100010: ALUCtrl_o <= 4'b0110; //sub
			6'b100100: ALUCtrl_o <= 4'b0000; //and
			6'b100101: ALUCtrl_o <= 4'b0001; //or
			6'b101010: ALUCtrl_o <= 4'b0111; //slt
			default: ALUCtrl_o <= 4'b1000;
		endcase
	end
end

endmodule     





                    
                    