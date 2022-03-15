








module Hazard_detection_unit(
	IF_ID_Rs_i,
	IF_ID_Rt_i,
	ID_EX_Rt_i,
	ID_EX_MemRead_i,
	Branch_i,
/*******lw stall*******/
	PCSrc_o,
	PCWrite_o,
	IF_IDWrite_o,		//same as IF_Flush(for branch taken)
	ID_Flush_o		//for mux before ID/EX
);

//I/O ports
input  [32-1:0] IF_ID_Rs_i;
input  [32-1:0] IF_ID_Rt_i;
input  [32-1:0] ID_EX_Rt_i;
input		ID_EX_MemRead_i;
input		Branch_i;

output		PCSrc_o;
output		PCWrite_o;
output		IF_IDWrite_o;
output		ID_Flush_o;


//Internal Signals

//Parameter

//Main function
always@(*)
begin
	if(ID_EX_MemRead_i & ((ID_EX_Rt_i == IF_ID_Rs_i) || (ID_EX_Rt_i == IF_ID_Rt_i)) // lw stall
	begin
		ID_Flush_o <= 1'b0;
		PCWrite_o <= 1'b0;
		IF_IDWrite_o <= 1'b0;
	end
	if(Branch_i == 1) // branch stall(1 bubble)
	begin
		IF_IDWrite_o <= 1'b0;
		PCSrc_o <= 1'b1;
	end
end

endmodule