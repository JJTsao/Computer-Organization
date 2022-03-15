








module Forwarding_unit(
	EX_MEM_RegWrite_i,
	EX_MEM_Rd_i,
	MEM_WB_RegWrite_i,
	MEM_WB_Rd_i,
	ID_EX_Rs_i,
	ID_EX_Rt_i,
	ForwardA_o,		//for ALU_src1_mux
	ForwardB_o		//for ALU_src2_mux
	);

//I/O ports
input		EX_MEM_RegWrite_i;
input  [5-1:0] EX_MEM_Rd_i;
input		MEM_WB_RegWrite_i;
input  [5-1:0] MEM_WB_Rd_i;
input  [5-1:0] ID_EX_Rs_i;
input  [5-1:0] ID_EX_Rt_i;
output [2-1:0]  ForwardA_o;
output [2-1:0]  ForwardB_o;

//Internal Signals

//Parameter

//Main function
always@(*)
begin
	if(EX_MEM_RegWrite_i & (EX_MEM_Rd_i != 0) & (EX_MEM_Rd_i == ID_EX_Rs_i))
		ForwardA_o <= 2'b10;
	else if(EX_MEM_RegWrite_i & (EX_MEM_Rd_i != 0) & (EX_MEM_Rd_i == ID_EX_Rt_i))
		ForwardB_o <= 2'b10;
	else if(MEM_WB_RegWrite_i & (MEM_WB_Rd != 0) & ~(EX_MEM_RegWrite_i & (EX_MEM_Rd_i != 0) & (EX_MEM_Rd_i == ID_EX_Rs_i)) & (MEM_WB_Rd_i == ID_EX_Rs_i))
		ForwardA_o <= 2'b01;
	else if(MEM_WB_RegWrite_i & (MEM_WB_Rd != 0) & ~(EX_MEM_RegWrite_i & (EX_MEM_Rd_i != 0) & (EX_MEM_Rd_i == ID_EX_Rt_i)) & (MEM_WB_Rd_i == ID_EX_Rt_i))
		ForwardB_o <= 2'b01;
end

endmodule

