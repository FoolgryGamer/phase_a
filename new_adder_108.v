module add1
#(parameter Size = 45, radix = 108)
(
	input [Size-1:0] a_0,
	input [Size-1:0] a_1,
	input [Size-1:0] a_2,
	input [Size-1:0] a_3,
	input [Size-1:0] a_4,
	input [Size-1:0] a_5,
	input [Size-1:0] a_6,
	input [Size-1:0] a_7,
	input [Size-1:0] a_8,
	input [Size-1:0] a_9,
	input [Size-1:0] a_10,
	input [Size-1:0] a_11,
	input [Size-1:0] a_12,
	input [Size-1:0] a_13,
	input [Size-1:0] a_14,
	input [Size-1:0] a_15,
	input [Size-1:0] a_16,
	input [Size-1:0] a_17,
	input [Size-1:0] a_18,
	input [Size-1:0] a_19,
	input [Size-1:0] a_20,
	input [Size-1:0] a_21,
	input [Size-1:0] a_22,
	input [Size-1:0] a_23,
	output [radix*2-1:0] res_0,
	output [radix*2-1:0] res_1,
	output [radix*2-1:0] res_2,
	output [radix*2-1:0] res_3,
	output [radix*2-1:0] res_4
);
    //need modify depends on the size or the radix
	wire [radix*2-1:0] a_0_w = {171'b0,a_0};
	wire [radix*2-1:0] a_1_w = {153'b0,a_1,18'b0};
	wire [radix*2-1:0] a_2_w = {135'b0,a_2,36'b0};
	wire [radix*2-1:0] a_3_w = {117'b0,a_3,54'b0};
	wire [radix*2-1:0] a_4_w = {99'b0,a_4,72'b0};
	wire [radix*2-1:0] a_5_w = {81'b0,a_5,90'b0};
	wire [radix*2-1:0] a_6_w = {144'b0,a_6,27'b0};
	wire [radix*2-1:0] a_7_w = {126'b0,a_7,45'b0};
	wire [radix*2-1:0] a_8_w = {108'b0,a_8,63'b0};
	wire [radix*2-1:0] a_9_w = {90'b0,a_9,81'b0};
	wire [radix*2-1:0] a_10_w = {72'b0,a_10,99'b0};
	wire [radix*2-1:0] a_11_w = {54'b0,a_11,117'b0};
	wire [radix*2-1:0] a_12_w = {117'b0,a_12,54'b0};
	wire [radix*2-1:0] a_13_w = {99'b0,a_13,72'b0};
	wire [radix*2-1:0] a_14_w = {81'b0,a_14,90'b0};
	wire [radix*2-1:0] a_15_w = {63'b0,a_15,108'b0};
	wire [radix*2-1:0] a_16_w = {45'b0,a_16,126'b0};
	wire [radix*2-1:0] a_17_w = {27'b0,a_17,144'b0};
	wire [radix*2-1:0] a_18_w = {90'b0,a_18,81'b0};
	wire [radix*2-1:0] a_19_w = {72'b0,a_19,99'b0};
	wire [radix*2-1:0] a_20_w = {54'b0,a_20,117'b0};
	wire [radix*2-1:0] a_21_w = {36'b0,a_21,135'b0};
	wire [radix*2-1:0] a_22_w = {18'b0,a_22,153'b0};
	wire [radix*2-1:0] a_23_w = {a_23,171'b0};

	add2_adder_5#(.adder_size(radix*2)) add2_0(a_0_w,a_1_w,a_2_w,a_3_w,a_4_w,res_0);
	add2_adder_5#(.adder_size(radix*2)) add2_1(a_5_w,a_6_w,a_7_w,a_8_w,a_9_w,res_1);
	add2_adder_5#(.adder_size(radix*2)) add2_2(a_10_w,a_11_w,a_12_w,a_13_w,a_14_w,res_2);
	add2_adder_5#(.adder_size(radix*2)) add2_3(a_15_w,a_16_w,a_17_w,a_18_w,a_19_w,res_3);
	add2_adder_5#(.adder_size(radix*2)) add2_4(a_20_w,a_21_w,a_22_w,a_23_w,216'b0,res_4);
endmodule

module add2_adder_5
#(parameter adder_size = 108)
(
	input [adder_size-1:0] a_0,
	input [adder_size-1:0] a_1,
	input [adder_size-1:0] a_2,
	input [adder_size-1:0] a_3,
	input [adder_size-1:0] a_4,
	output [adder_size-1:0] res
);
	assign res = a_0+a_1+a_2+a_3+a_4;
endmodule

module add2_adder_2
#(parameter adder_size = 108)
(
	input [adder_size-1:0] a_0,
	input [adder_size-1:0] a_1,
	output [adder_size-1:0] res
);
	assign res = a_0+a_1;
endmodule