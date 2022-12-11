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
`define INTERVAL 22

module multiplier_upper_2_bit
(#parameter mul_size = 66) 
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
	wire [INTERVAL-1:0] wire_a [2:0];
	wire [INTERVAL-1:0] wire_b [2:0];

	//this part needs to be change based on the partition strategy
	assign wire_a[0] = a[INTERVAL-1:0];
	assign wire_a[1] = a[INTERVAL*2-1:INTERVAL];
	assign wire_a[2] = a[INTERVAL*3-1:INTERVAL*2];
	assign wire_b[0] = b[INTERVAL-1:0];
	assign wire_b[1] = b[INTERVAL*2-1:INTERVAL];
	assign wire_b[2] = b[INTERVAL*3-1:INTERVAL*2];
	
    //used for store the intermediate results
	wire [mul_size*2-1:0] out[8:0];
	wire [mul_size*2-1:0] tmp[2:0];
	wire [mul_size*2-1:0] res_t;

    // multiply, each cost a dsp slice
    assign out[0] = wire_a[0]*wire_b[0];
	assign out[1] = (wire_a[0]*wire_b[1]) << INTERVAL;
	assign out[2] = (wire_a[0]*wire_b[2]) << INTERVAL*2;
	assign out[3] = (wire_a[1]*wire_b[0]) << INTERVAL;
	assign out[4] = (wire_a[1]*wire_b[1]) << INTERVAL*2;
	assign out[5] = (wire_a[1]*wire_b[2]) << INTERVAL*3;
	assign out[6] = (wire_a[2]*wire_b[0]) << INTERVAL*2;
	assign out[7] = (wire_a[2]*wire_b[1]) << INTERVAL*3;
	assign out[8] = (wire_a[2]*wire_b[2]) << INTERVAL*4;

    add2 #(.radix(mul_size)) add_inst_0(.a_0(out[0]),.a_1(out[1]),.a_2(out[2]),.res(tmp[0]));
    add2 #(.radix(mul_size)) add_inst_1(.a_0(out[3]),.a_1(out[4]),.a_2(out[5]),.res(tmp[1]));
    add2 #(.radix(mul_size)) add_inst_2(.a_0(out[6]),.a_1(out[7]),.a_2(out[8]),.res(tmp[2]));
    add2 #(.radix(mul_size)) add_inst_2(.a_0(tmp[0]),.a_1(tmp[1]),.a_2(tmp[2]));
	assign res = res_t[131:130];
endmodule

module multiplier_middle_bit
(#parameter mul_size = 66) 
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
	wire [21:0] wire_a [2:0];
	wire [21:0] wire_b [2:0];
	assign wire_a[0] = a[INTERVAL-1:0];
	assign wire_a[1] = a[INTERVAL*2-1:INTERVAL];
	assign wire_a[2] = a[INTERVAL*3-1:INTERVAL*2];
	assign wire_b[0] = b[INTERVAL-1:0];
	assign wire_b[1] = b[INTERVAL*2-1:INTERVAL];
	assign wire_b[2] = b[INTERVAL*3-1:INTERVAL*2];
	
    //used for store the intermediate results
	wire [mul_size*2-1:0] out[8:0];
	wire [mul_size*2-1:0] tmp[2:0];
	wire [mul_size*2-1:0] res_t;

    // multiply, each cost a dsp slice
    assign out[0] = wire_a[0]*wire_b[0];
	assign out[1] = (wire_a[0]*wire_b[1]) << INTERVAL;
	assign out[2] = (wire_a[0]*wire_b[2]) << INTERVAL*2;
	assign out[3] = (wire_a[1]*wire_b[0]) << INTERVAL;
	assign out[4] = (wire_a[1]*wire_b[1]) << INTERVAL*2;
	assign out[5] = (wire_a[1]*wire_b[2]) << INTERVAL*3;
	assign out[6] = (wire_a[2]*wire_b[0]) << INTERVAL*2;
	assign out[7] = (wire_a[2]*wire_b[1]) << INTERVAL*3;
	assign out[8] = (wire_a[2]*wire_b[2]) << INTERVAL*4;

    add2 #(.radix(mul_size)) add_inst_0(.a_0(out[0]),.a_1(out[1]),.a_2(out[2]),.res(tmp[0]));
    add2 #(.radix(mul_size)) add_inst_1(.a_0(out[3]),.a_1(out[4]),.a_2(out[5]),.res(tmp[1]));
    add2 #(.radix(mul_size)) add_inst_2(.a_0(out[6]),.a_1(out[7]),.a_2(out[8]),.res(tmp[2]));
    add2 #(.radix(mul_size)) add_inst_2(.a_0(tmp[0]),.a_1(tmp[1]),.a_2(tmp[2]));
	assign res = res_t[127:64];
endmodule
