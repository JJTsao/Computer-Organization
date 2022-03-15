`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
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

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire   [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;
reg    [32-1:0] tmp;

reg		set;
reg 		carryin;
wire   [32-1:0] carryout;
wire   [32-1:0] temp;

alu_top bit0(
	.src1(src1[0]),
	.src2(src2[0]),
	.less(set),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryin),
	.operation(ALU_control[1:0]),
	.result(temp[0]),
	.cout(carryout[0])
	);

alu_top bit1(
	.src1(src1[1]),
	.src2(src2[1]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[0]),
	.operation(ALU_control[1:0]),
	.result(temp[1]),
	.cout(carryout[1])
	);

alu_top bit2(
	.src1(src1[2]),
	.src2(src2[2]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[1]),
	.operation(ALU_control[1:0]),
	.result(temp[2]),
	.cout(carryout[2])
	);

alu_top bit3(
	.src1(src1[3]),
	.src2(src2[3]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[2]),
	.operation(ALU_control[1:0]),
	.result(temp[3]),
	.cout(carryout[3])
	);

alu_top bit4(
	.src1(src1[4]),
	.src2(src2[4]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[3]),
	.operation(ALU_control[1:0]),
	.result(temp[4]),
	.cout(carryout[4])
	);

alu_top bit5(
	.src1(src1[5]),
	.src2(src2[5]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[4]),
	.operation(ALU_control[1:0]),
	.result(temp[5]),
	.cout(carryout[5])
	);

alu_top bit6(
	.src1(src1[6]),
	.src2(src2[6]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[5]),
	.operation(ALU_control[1:0]),
	.result(temp[6]),
	.cout(carryout[6])
	);

alu_top bit7(
	.src1(src1[7]),
	.src2(src2[7]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[6]),
	.operation(ALU_control[1:0]),
	.result(temp[7]),
	.cout(carryout[7])
	);

alu_top bit8(
	.src1(src1[8]),
	.src2(src2[8]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[7]),
	.operation(ALU_control[1:0]),
	.result(temp[8]),
	.cout(carryout[8])
	);

alu_top bit9(
	.src1(src1[9]),
	.src2(src2[9]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[8]),
	.operation(ALU_control[1:0]),
	.result(temp[9]),
	.cout(carryout[9])
	);

alu_top bit10(
	.src1(src1[10]),
	.src2(src2[10]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[9]),
	.operation(ALU_control[1:0]),
	.result(temp[10]),
	.cout(carryout[10])
	);

alu_top bit11(
	.src1(src1[11]),
	.src2(src2[11]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[10]),
	.operation(ALU_control[1:0]),
	.result(temp[11]),
	.cout(carryout[11])
	);

alu_top bit12(
	.src1(src1[12]),
	.src2(src2[12]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[11]),
	.operation(ALU_control[1:0]),
	.result(temp[12]),
	.cout(carryout[12])
	);

alu_top bit13(
	.src1(src1[13]),
	.src2(src2[13]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[12]),
	.operation(ALU_control[1:0]),
	.result(temp[13]),
	.cout(carryout[13])
	);

alu_top bit14(
	.src1(src1[14]),
	.src2(src2[14]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[13]),
	.operation(ALU_control[1:0]),
	.result(temp[14]),
	.cout(carryout[14])
	);

alu_top bit15(
	.src1(src1[15]),
	.src2(src2[15]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[14]),
	.operation(ALU_control[1:0]),
	.result(temp[15]),
	.cout(carryout[15])
	);

alu_top bit16(
	.src1(src1[16]),
	.src2(src2[16]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[15]),
	.operation(ALU_control[1:0]),
	.result(temp[16]),
	.cout(carryout[16])
	);

alu_top bit17(
	.src1(src1[17]),
	.src2(src2[17]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[16]),
	.operation(ALU_control[1:0]),
	.result(temp[17]),
	.cout(carryout[17])
	);

alu_top bit18(
	.src1(src1[18]),
	.src2(src2[18]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[17]),
	.operation(ALU_control[1:0]),
	.result(temp[18]),
	.cout(carryout[18])
	);

alu_top bit19(
	.src1(src1[19]),
	.src2(src2[19]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[18]),
	.operation(ALU_control[1:0]),
	.result(temp[19]),
	.cout(carryout[19])
	);

alu_top bit20(
	.src1(src1[20]),
	.src2(src2[20]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[19]),
	.operation(ALU_control[1:0]),
	.result(temp[20]),
	.cout(carryout[20])
	);

alu_top bit21(
	.src1(src1[21]),
	.src2(src2[21]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[20]),
	.operation(ALU_control[1:0]),
	.result(temp[21]),
	.cout(carryout[21])
	);

alu_top bit22(
	.src1(src1[22]),
	.src2(src2[22]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[21]),
	.operation(ALU_control[1:0]),
	.result(temp[22]),
	.cout(carryout[22])
	);

alu_top bit23(
	.src1(src1[23]),
	.src2(src2[23]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[22]),
	.operation(ALU_control[1:0]),
	.result(temp[23]),
	.cout(carryout[23])
	);

alu_top bit24(
	.src1(src1[24]),
	.src2(src2[24]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[23]),
	.operation(ALU_control[1:0]),
	.result(temp[24]),
	.cout(carryout[24])
	);

alu_top bit25(
	.src1(src1[25]),
	.src2(src2[25]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[24]),
	.operation(ALU_control[1:0]),
	.result(temp[25]),
	.cout(carryout[25])
	);

alu_top bit26(
	.src1(src1[26]),
	.src2(src2[26]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[25]),
	.operation(ALU_control[1:0]),
	.result(temp[26]),
	.cout(carryout[26])
	);

alu_top bit27(
	.src1(src1[27]),
	.src2(src2[27]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[26]),
	.operation(ALU_control[1:0]),
	.result(temp[27]),
	.cout(carryout[27])
	);

alu_top bit28(
	.src1(src1[28]),
	.src2(src2[28]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[27]),
	.operation(ALU_control[1:0]),
	.result(temp[28]),
	.cout(carryout[28])
	);

alu_top bit29(
	.src1(src1[29]),
	.src2(src2[29]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[28]),
	.operation(ALU_control[1:0]),
	.result(temp[29]),
	.cout(carryout[29])
	);

alu_top bit30(
	.src1(src1[30]),
	.src2(src2[30]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[29]),
	.operation(ALU_control[1:0]),
	.result(temp[30]),
	.cout(carryout[30])
	);

alu_top bit31(
	.src1(src1[31]),
	.src2(src2[31]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(carryout[30]),
	.operation(ALU_control[1:0]),
	.result(temp[31]),
	.cout(carryout[31])
	);

always@( posedge clk )
begin
	if(rst_n) tmp[32-1:0] <= temp[32-1:0]; 
end

assign result[32-1:0] = tmp[32-1:0]; 

always@( posedge clk )
begin
	if(temp == 32'b0) zero <= 1'b1;
	else zero <= 1'b0;
end

always@( posedge clk )
begin
	if(ALU_control == 4'b0111) set = result[31];
end

always@( posedge clk )
begin
	if(ALU_control == 4'b0010) // add
	begin
		if(src1[31]==src2[31])begin
			cout = carryout[30];
		end
		else begin
			cout = 1'b0;
		end
	end
	else if(ALU_control == 4'b0110) //sub
	begin
		if(src1[31]==src2[31])begin
			cout = 1'b0;
		end
		else begin
			cout = carryout[30];
		end
	end
	else cout = 1'b0;
end

always@( posedge clk )
begin
	if(ALU_control == 4'b0010)
	begin
		if((src1[31] == src2[31]) && (src1[31] != temp[31])) overflow <= 1'b1;
		else overflow <= 1'b0;
	end
	else if(ALU_control == 4'b0110)
	begin
		if((src1[31] != src2[31]) && (src1[31] != temp[31])) overflow <= 1'b1;
		else overflow <= 1'b0;
	end
	else overflow <= 1'b0;
end

always@(*)
begin
	if(ALU_control == 4'b0110) carryin = 1'b1;
	else if(ALU_control == 4'b0111) carryin = 1'b1;
	else carryin = 1'b0;
end


/*always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n) begin
		set <= 1'b0;
		zero <= 1'b0;
		cout <= 1'b0;
		overflow <= 1'b0;
	end
	else begin
		
		
		set = result[31];
		
		
		
zero	//nor n1( zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29], result[30], result[31]);

		if(src1[31]==src2[31])begin
			cout = carryout[30];
		end
		else begin
			cout = 1'b0;
		end

		
	end
end
*/
endmodule
