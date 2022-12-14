module add1
#(parameter Size = 45, radix = 54)
(
	input [Size-1:0] a_0,
	input [Size-1:0] a_1,
	input [Size-1:0] a_2,
	input [Size-1:0] a_3,
	input [Size-1:0] a_4,
	input [Size-1:0] a_5,
	output [radix*2-1:0] res_0,
	output [radix*2-1:0] res_1
);
    //need modify depends on the size or the radix
	wire [radix*2-1:0] a_0_w = {63'b0,a_0};
	wire [radix*2-1:0] a_1_w = {45'b0,a_1,18'b0};
	wire [radix*2-1:0] a_2_w = {27'b0,a_2,36'b0};
	wire [radix*2-1:0] a_3_w = {36'b0,a_3,27'b0};
	wire [radix*2-1:0] a_4_w = {18'b0,a_4,45'b0};
	wire [radix*2-1:0] a_5_w = {a_5,63'b0};

	add2 add2_0(a_0_w,a_1_w,a_2_w,res_0);
	add2 add2_1(a_4_w,a_5_w,a_6_w,res_1);
endmodule

module add2_adder_3
#(parameter adder_size = 108)
(
	input [adder_size-1:0] a_0,
	input [adder_size-1:0] a_1,
	input [adder_size-1:0] a_2,
	output [adder_size-1:0] res
);
	assign res = a_0+a_1+a_2;
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

// add more adder version
// module add2_3_input_verison
// #(radix = 54)
// (
// 	input [radix*2-1:0] a_0,
// 	input [radix*2-1:0] a_1,
// 	input [radix*2-1:0] a_2,
// 	output [radix*2-1:0] res
// );
// 	assign res = a_0+a_1+a_2;
// endmodule
