//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signals

//PC
wire [32-1:0] new_address;
wire [32-1:0] cur_address;

//PC+4
wire [32-1:0] Add1;

//Instruction 
wire [32-1:0] instr;

//register destination
wire [5-1:0] WriteReg;

//register file
wire [32-1:0] ReadData1;
wire [32-1:0] ReadData2;
wire [32-1:0] WriteData;

//data memory
wire [32-1:0] Readdata;

//decoder
wire	     RegWrite;
wire [3-1:0] ALUOp;
wire	     ALUSrc;
wire [2-1:0] RegDst;
wire	     Branch;
wire [2-1:0] MemToReg;
wire [2-1:0] BranchType;
wire	     Jump;
wire	     MemRead;
wire	     MemWrite;
wire	     JumpToReg;

//sign extend
wire [32-1:0] extend;

//ALU control
wire [4-1:0] ALUCtrl;

//ALUsrc2 mux
wire [32-1:0] ALUSrc2_mux;

//Shift left 2 for branch
wire [32-1:0] Shift1;

//Shift left 2 for jump
wire [32-1:0] Shift2;

//jump address
wire [32-1:0] jump_address;

//Adder for branch
wire [32-1:0] Add2;

//BranchOrNot mux output
wire [32-1:0] Branch_mux;

//ALU
wire zero;
wire [32-1:0] ALU_result;

//And
wire _and;

//jump mux
wire [32-1:0] JumpOut;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(new_address) ,   
	    .pc_out_o(cur_address) 
	    );
	
Adder Adder1(
        .src1_i(cur_address),     
	    .src2_i(32'd4),     
	    .sum_o(Add1)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(cur_address),  
	    .instr_o(instr)    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
	.data2_i(5'b11111),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(WriteReg) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(ReadData1) ,  
        .RTdata_o(ReadData2)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	.instr_fun_i(instr[5:0]),
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch),
		.MemToReg_o(MemToReg),
		.BranchType_o(BranchType),
		.Jump_o(Jump),
		.MemRead_o(MemRead),
		.MemWrite_o(MemWrite),
		.JumpToReg_o(JumpToReg)
	    );

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(extend)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(ReadData2),
        .data1_i(extend),
        .select_i(ALUSrc),
        .data_o(ALUSrc2_mux)
        );	
		
ALU ALU(
        .src1_i(ReadData1),
	    .src2_i(ALUSrc2_mux),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );

/*MUX_4to1 #(.size(32)) BranchType_mux(
	.data0_i(),
        .data1_i(),
	.data2_i(),
	.data3_i(),
        .select_i(),
        .data_o()
        ); */
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_result),
	.data_i(ReadData2),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(Readdata)
	);

MUX_3to1 #(.size(32)) MemToReg_mux(
	.data0_i(ALU_result),
        .data1_i(Readdata),
	.data2_i(Add1), //Add1
        .select_i(MemToReg),
        .data_o(WriteData)
        );

Adder Adder2(
        .src1_i(cur_address),     
	    .src2_i(Shift1),     
	    .sum_o(Add2)      
	    );
		
Shift_Left_Two_32 Shifter1(
        .data_i(extend),
        .data_o(Shift1)
        ); 		
assign _and = Branch & zero; // to modify

MUX_2to1 #(.size(32)) Mux_BranchOrNot(
	.data0_i(Add1),
        .data1_i(Add2),
        .select_i(_and),
        .data_o(Branch_mux)
        );

Shift_Left_Two_32 Shifter2(
        .data_i({6'b000000, instr[25:0]}),
        .data_o(Shift2)
        );

assign jump_address = {Add1[31:28], Shift2[27:0]};

MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(jump_address),
        .data1_i(Branch_mux),
        .select_i(Jump),
        .data_o(JumpOut)
        );	

MUX_2to1 #(.size(32)) FinalPC_mux(
        .data0_i(JumpOut),
        .data1_i(ReadData1),
        .select_i(JumpToReg),
        .data_o(new_address)
        );	

endmodule
		  


