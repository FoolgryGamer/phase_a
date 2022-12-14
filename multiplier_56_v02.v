`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 16:03:28
// Design Name: 
// Module Name: multiplier_66
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////*from multiplier_66*/////////////////////////////////////

module multiplier_upper_2_bit
#(parameter mul_size = 56,radix = 54) 
(
	input clk,
	input rst_n,
	input [mul_size-1:0] a,
	input [mul_size-1:0] b,
	output [1:0] res
);
    //***************************
    //Below part need modification manually
    //This part is associated with the number of DSP slice
	wire [17:0] wire_a_low [1:0];
	wire [19:0] wire_a_high;
	wire [17:0] wire_b_low [1:0];
	wire [19:0] wire_b_high;

	//this part needs to be change based on the partition strategy
	assign wire_a_low[0] = a[17:0];
	assign wire_a_low[1] = a[35:18];
	assign wire_a_high = a[55:36];
	assign wire_b_low[0] = b[17:0];
	assign wire_b_low[1] = b[35-1:18];
	assign wire_b_high = b[55:36];
	
    //used for store the intermediate results
	wire [mul_size*2-1:0] out[8:0];
	wire [mul_size*2-1:0] tmp[2:0];
	wire [mul_size*2-1:0] res_t;

    // multiply, each cost a dsp slice
    assign out[0] = wire_a_low[0]*wire_b_low[0];
	assign out[1] = (wire_a_low[0]*wire_b_low[1]) << 18;
	assign out[2] = (wire_a_low[0]*wire_b_high) << 36;
	assign out[3] = (wire_a_low[1]*wire_b_low[0]) << 18;
	assign out[4] = (wire_a_low[1]*wire_b_low[1]) << 36;
	assign out[5] = (wire_a_low[1]*wire_b_high) << 54;
	assign out[6] = (wire_a_high*wire_b_low[0]) << 36;
	assign out[7] = (wire_a_high*wire_b_low[1]) << 54;
	assign out[8] = (wire_a_high*wire_b_high) << 72;

    add2_adder_3 #(.radix(mul_size*2)) add_inst_0(.a_0(out[0]),.a_1(out[1]),.a_2(out[2]),.res(tmp[0]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_1(.a_0(out[3]),.a_1(out[4]),.a_2(out[5]),.res(tmp[1]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_2(.a_0(out[6]),.a_1(out[7]),.a_2(out[8]),.res(tmp[2]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_3(.a_0(tmp[0]),.a_1(tmp[1]),.a_2(tmp[2]),.res(res_t));
	assign res = res_t[radix*2+3:radix*2+2];
endmodule

module multiplier_middle_bit
#(parameter mul_size = 56,radix = 54) 
(
	input clk,
	input rst_n,
	input [mul_size-1:0] a,
	input [mul_size-1:0] b,
	output [1:0] res
);
	//***************************
    //Below part need modification manually
    //This part is associated with the number of DSP slice
	wire [17:0] wire_a_low [1:0];
	wire [19:0] wire_a_high;
	wire [17:0] wire_b_low [1:0];
	wire [19:0] wire_b_high;

	//this part needs to be change based on the partition strategy
	assign wire_a_low[0] = a[17:0];
	assign wire_a_low[1] = a[35:18];
	assign wire_a_high = a[55:36];
	assign wire_b_low[0] = b[17:0];
	assign wire_b_low[1] = b[35-1:18];
	assign wire_b_high = b[55:36];
	
    //used for store the intermediate results
	wire [mul_size*2-1:0] out[8:0];
	wire [mul_size*2-1:0] tmp[2:0];
	wire [mul_size*2-1:0] res_t;

    // multiply, each cost a dsp slice
    assign out[0] = wire_a_low[0]*wire_b_low[0];
	assign out[1] = (wire_a_low[0]*wire_b_low[1]) << 18;
	assign out[2] = (wire_a_low[0]*wire_b_high) << 36;
	assign out[3] = (wire_a_low[1]*wire_b_low[0]) << 18;
	assign out[4] = (wire_a_low[1]*wire_b_low[1]) << 36;
	assign out[5] = (wire_a_low[1]*wire_b_high) << 54;
	assign out[6] = (wire_a_high*wire_b_low[0]) << 36;
	assign out[7] = (wire_a_high*wire_b_low[1]) << 54;
	assign out[8] = (wire_a_high*wire_b_high) << 72;

    add2_adder_3 #(.radix(mul_size*2)) add_inst_0(.a_0(out[0]),.a_1(out[1]),.a_2(out[2]),.res(tmp[0]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_1(.a_0(out[3]),.a_1(out[4]),.a_2(out[5]),.res(tmp[1]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_2(.a_0(out[6]),.a_1(out[7]),.a_2(out[8]),.res(tmp[2]));
    add2_adder_3 #(.radix(mul_size*2)) add_inst_3(.a_0(tmp[0]),.a_1(tmp[1]),.a_2(tmp[2]),.res(res_t));
	assign res = res_t[radix*2-1:radix];
endmodule
