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

//Internal Signles

//program counter
wire [32-1:0] new_address;
wire [32-1:0] cur_address;

//add 4 bits
wire [32-1:0] Add;

//Instruction Memory
wire [32-1:0] instruction;

//5 bits mux
wire [5-1:0] WriteReg;

//Register File
wire [32-1:0] Read_Data1;
wire [32-1:0] Read_Data2;

//Decoder
wire          RegWrite;
wire [3-1:0]  ALUOp;
wire          ALUSrc;
wire          RegDst;
wire          Branch;

//Sign Extend
wire [32-1:0] extend;

//ALU Control
wire [4-1:0]  ALUCtrl;

//Sign Extend and Read Data 2 mux
wire [32-1:0] Read_Data2_mux;

//Shift left 2
wire [32-1:0] shift_left2;

//Add
wire [32-1:0] Add2;

//ALU
wire zero;
wire [32-1:0] ALU_result;

//And
wire _and;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(new_address) ,   
	    .pc_out_o(cur_address) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(cur_address),     
	    .sum_o(Add)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(cur_address),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(WriteReg) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(Read_Data1) ,  
        .RTdata_o(Read_Data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(extend)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(Read_Data2),
        .data1_i(extend),
        .select_i(ALUSrc),
        .data_o(Read_Data2_mux)
        );	
		
ALU ALU(
        .src1_i(Read_Data1),
	    .src2_i(Read_Data2_mux),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(Add),     
	    .src2_i(shift_left2),     
	    .sum_o(Add2)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extend),
        .data_o(shift_left2)
        ); 		
assign _and = Branch & zero;		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Add),
        .data1_i(Add2),
        .select_i(_and),
        .data_o(new_address)
        );	

endmodule
		  


