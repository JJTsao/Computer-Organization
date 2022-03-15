`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
//PC
wire [32-1:0] new_address;
wire [32-1:0] cur_address;
wire          PCWrite;
//PC+4
wire [32-1:0] Add1;

//Instruction 
wire [32-1:0] instr;

//register file
wire [32-1:0] ReadData1;
wire [32-1:0] ReadData2;
wire [5-1:0] WriteReg;
wire [32-1:0] WriteData;

//data memory
wire [32-1:0] Readdata;

//decoder
wire	     RegWrite;
wire [3-1:0] ALUOp;
wire	     ALUSrc;
wire 	     RegDst;
wire	     Branch;
wire 	     MemToReg;
				//wire [2-1:0] BranchType;
				//wire	     Jump;
wire	     MemRead;
wire	     MemWrite;
				//wire	     JumpToReg;
wire [10-1:0] signals;
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

//Adder for branch
wire [32-1:0] Add2;

//Branch or not
wire PCSrc;
wire Taken;
//ALU
wire zero;
wire [32-1:0] ALU_result;


/**** IF stage ****/
wire [65-1:0] IF_ID_o;

/**** ID stage ****/
wire [148-1:0]ID_EX_o;
//control signal
wire [10-1:0] IDEXMux;

/**** EX stage ****/
wire [107-1:0]   EX_MEM_o;
//control signal
wire [2-1:0]  ForwardA;
wire [2-1:0]  ForwardB;
wire [5-1:0]  Dst_mux;

/**** MEM stage ****/
wire [71-1:0]	 MEM_WB_o;
//control signal


/**** WB stage ****/

//control signal


/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage

MUX_2to1 #(.size(32)) Mux0(
	.data0_i(Add1),
        .data1_i(Add2), //compute ready at ID stage, data1_i = Add2
        .select_i(PCSrc), // Hazard_detection_unit PCSrc_o
        .data_o(new_address)
);

ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.PCWrite(PCWrite),
	.pc_in_i(new_address),
	.pc_out_o(cur_address)
);

Instruction_Memory IM(
	.addr_i(cur_address),
	.instr_o(instr)
);
			
Adder Add_pc(
	.src1_i(cur_address),
	.src2_i(32'd4),
	.sum_o(Add1)
);

		
Pipe_Reg #(.size(65)) IF_ID(       //N is the total length of input/output
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({IF_IDWrite, Add1, instr}),  //here
	.data_o(IF_ID_o)
);


//Instantiate the components in ID stage
Reg_File RF(
	.clk_i(clk_i),      
	.rst_i(rst_i) ,     
	.RegWrite_i(MEM_WB_o[70]),  //
        .RSaddr_i(IF_ID_o[25:21]) ,  
        .RTaddr_i(IF_ID_o[20:16]) ,  
        .RDaddr_i(MEM_WB_o[4:0]) ,  //
        .RDdata_i(WriteData)  , 
        
        .RSdata_o(ReadData1) ,  
        .RTdata_o(ReadData2)
);

Decoder Control(
	.instr_op_i(IF_ID_o[31:26]), 
		//.instr_fun_i(instr[5:0]),
	.RegWrite_o(RegWrite), 
	.ALU_op_o(ALUOp),   
	.ALUSrc_o(ALUSrc),   
	.RegDst_o(RegDst),   
	.Branch_o(Branch),
	.MemToReg_o(MemToReg),
		//.BranchType_o(BranchType),
		//.Jump_o(Jump),
	.MemRead_o(MemRead),
	.MemWrite_o(MemWrite)
		//.JumpToReg_o(JumpToReg)
);

assign signals = {RegWrite, MemToReg, Branch, MemRead, 
			MemWrite, ALUOp, ALUSrc, RegDst};

Sign_Extend Sign_Extend(
	.data_i(IF_ID_o[15:0]),
	.data_o(extend)
);

Shift_Left_Two_32 Shifter(
	.data_i(extend),
	.data_o(Shift1)
);

assign Taken = Branch & (IF_ID_o[25:21] == IF_ID_o[20:16]);

Adder Add_pc_branch(
  	.src1_i(IF_ID_o[63:32]),
	.src2_i(Shift1),
	.sum_o(Add2)
);

MUX_2to1 #(.size(10)) ID_EXMux(
	.data0_i(10'b0),
        .data1_i(signals),
        .select_i(ID_Flush),
        .data_o(IDEXMux)
);

Hazard_detection_unit H(
	.IF_ID_Rs_i(IF_ID_o[25:21]),
	.IF_ID_Rt_i(IF_ID_o[20:16]),
	.ID_EX_Rt_i(ID_EX_o[4:0]),
	.ID_EX_MemRead_i(MemRead),
	.Branch_i(Taken),

	.PCSrc_o(PCSrc),
	.PCWrite_o(PCWrite),
	.IF_IDWrite_o(IF_IDWrite),
	.ID_Flush_o(ID_Flush)
);

Pipe_Reg #(.size(148)) ID_EX(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({IDEXMux, IF_ID_o[63:32], 
				ReadData1, ReadData2, extend, IF_ID_o[20:11]}),
	.data_o(ID_EX_o)
);


//Instantiate the components in EX stage	   

MUX_3to1 ALUSrc1(
	data0_i(),
        data1_i(),
        data2_i(),
        select_i(),
        data_o()
               );

ALU ALU(
	.src1_i(ALUSrc1_mux),
	.src2_i(ALUSrc2_mux),
	.ctrl_i(ALUCtrl),
	.result_o(ALU_result),
	.zero_o(zero)
);
		
ALU_Ctrl ALU_Control(
	.funct_i(ID_EX_o[15:10]),   
        .ALUOp_i(ID_EX_o[142:140]),
        .ALUCtrl_o(ALUCtrl)
);

MUX_2to1 #(.size(32)) Mux1(
	.data0_i(ID_EX_o[73:42]),
        .data1_i(ID_EX_o[41:10]),
        .select_i(ID_EX_o[139]),
        .data_o(ALUSrc2_mux)
);
		
MUX_2to1 #(.size(5)) Mux2(
	.data0_i(ID_EX_o[9:5]),
	.data1_i(ID_EX_o[4:0]),
	.select_i(ID_EX_o[138]), 
	.data_o(Dst_mux)
);

Forwarding_unit F(
	.EX_MEM_RegWrite_i(EX_MEM_o[106]),
	.EX_MEM_Rd_i(EX_MEM_o[4:0]),
	.MEM_WB_RegWrite_i(MEM_WB_o[70]),
	.MEM_WB_Rd_i(MEM_WB_o[4:0]),
	.ID_EX_Rs_i(ID_EX_o[9:5]),
	.ID_EX_Rt_i(ID_EX_o[4:0]),
	.ForwardA_o(ForwardA),		
	.ForwardB_o(ForwardB)		
	);


Pipe_Reg #(.size(107)) EX_MEM(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({ID_EX_o[147:143], 32'b0, zero, ALU_result, ID_EX_o[73:42], Dst_mux}),
	.data_o(EX_MEM_o)
);


//Instantiate the components in MEM stage
Data_Memory DM(
	.clk_i(clk_i),
    	.addr_i(EX_MEM_o[68:37]),
    	.data_i(EX_MEM_o[36:5]),
    	.MemRead_i(EX_MEM_o[103]),
    	.MemWrite_i(EX_MEM_o[102]),
    	.data_o(Readdata)
);

Pipe_Reg #(.size(71)) MEM_WB(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({EX_MEM_o[106:105], Readdata, EX_MEM_o[68:37], EX_MEM_o[4:0]}),
	.data_o(MEM_WB_o)
);

//assign PCSrc = EX_MEM_o[104] & EX_MEM_o[69];

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
	.data0_i(MEM_WB_o[68:37]),
        .data1_i(MEM_WB_o[36:5]),
        .select_i(MEM_WB_o[69]),
        .data_o(WriteData)
);
//assign WriteReg = MEM_WB_o[4:0];
//assign RegWrite = MEM_WB_o[70];
/****************************************
signal assignment
****************************************/

endmodule

