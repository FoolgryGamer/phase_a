`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 10:29:43
// Design Name: 
// Module Name: inner_loop_new
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

/////////////////////////////////////////////*from inner_loop_new*//////////////////////////////////////

module inner_loop_new
#(parameter Size = 3072, Size_bi = 64, loop_round = 57,radix = 54)
(
	input clk,
	input rst_n,
	input [Size_bi-1:0] bi,
	input [Size+1:0] a,
	input en,
	output reg [Size+Size_bi+1:0] r0,// 3072+64 = 3136  3136+2=3138
	output reg [Size+Size_bi+1:0] r1,
	output en_out
    );
    wire [65:0] more = 2'b11*bi;
	wire [65:0] more_bit = a[3073]?more:66'b0;
	
	integer j,p,q,k;
	reg [2:0] cnt;
	
	reg [63:0] multi_a[15:0];
	// new 54*54 multiplier parameter part
	wire [44:0] multi_res_0[15:0],multi_res_1[15:0],multi_res_2[15:0],multi_res_2[15:0],multi_res_3[15:0],multi_res_4[15:0],multi_res_5[15:0];

	
	reg [31:0] add1_a_0[15:0], add1_a_1[15:0], add1_a_2[15:0], add1_a_3[15:0];
	reg [39:0] add1_a_4[15:0], add1_a_5[15:0], add1_a_6[15:0], add1_a_7[15:0],add1_a_8[15:0], add1_a_9[15:0], add1_a_10[15:0], add1_a_11[15:0];
	wire [127:0] add1_res_0[15:0],add1_res_1[15:0],add1_res_2[15:0];
	
	reg [127:0] add2_a_0[15:0], add2_a_1[15:0], add2_a_2[15:0];
	wire [127:0] add2_res[15:0];
	
	always @(posedge clk) begin
		if(~rst_n) begin
			cnt <= 3'd0;
			for(j=0;j<16;j=j+1) begin
				multi_a[j] <= 0;
			end
			for(p=0;p<16;p=p+1) begin
				add1_a_0[p] <= 0;
				add1_a_1[p] <= 0;
				add1_a_2[p] <= 0;
				add1_a_3[p] <= 0;
				add1_a_4[p] <= 0;
				add1_a_5[p] <= 0;
				add1_a_6[p] <= 0;
				add1_a_7[p] <= 0;
				add1_a_8[p] <= 0;
				add1_a_9[p] <= 0;
				add1_a_10[p] <= 0;
				add1_a_11[p] <= 0;
			end
			for(q=0;q<16;q=q+1) begin
				add2_a_0[q] <= 0;
				add2_a_1[q] <= 0;
				add2_a_2[q] <= 0;
				// add2_a_3[q] <= 0;
			end
	        r0 <= 0;
	        r1 <= 0;
		end
		else begin
		if(en) begin
			cnt <= 3'd1;
			for(j=0;j<16;j=j+1) begin
				multi_a[j] <= a[(64*j)+:64];
			end
		end
		if(cnt == 3'd1) begin
			cnt <= 3'd2;
			r0[3137:3072] <= more_bit;
			for(j=16;j<32;j=j+1) begin
				multi_a[j-16] <= a[(64*j)+:64];
			end
			for(p=0;p<16;p=p+1) begin
				add1_a_0[p] <= multi_res_low_0[p];
				add1_a_1[p] <= multi_res_low_1[p];
				add1_a_2[p] <= multi_res_low_2[p];
				add1_a_3[p] <= multi_res_low_3[p];
				add1_a_4[p] <= multi_res_high_0[p];
				add1_a_5[p] <= multi_res_high_1[p];
				add1_a_6[p] <= multi_res_high_2[p];
				add1_a_7[p] <= multi_res_high_3[p];
				add1_a_8[p] <= multi_res_high_4[p];
				add1_a_9[p] <= multi_res_high_5[p];
				add1_a_10[p] <= multi_res_high_6[p];
				add1_a_11[p] <= multi_res_high_7[p];
			end
		end
		else if(cnt == 3'd2) begin
			cnt <= 3'd3;
			for(j=32;j<48;j=j+1) begin
				multi_a[j-32] <= a[(64*j)+:64];
			end
			for(p=0;p<16;p=p+1) begin
				add1_a_0[p] <= multi_res_low_0[p];
				add1_a_1[p] <= multi_res_low_1[p];
				add1_a_2[p] <= multi_res_low_2[p];
				add1_a_3[p] <= multi_res_low_3[p];
				add1_a_4[p] <= multi_res_high_0[p];
				add1_a_5[p] <= multi_res_high_1[p];
				add1_a_6[p] <= multi_res_high_2[p];
				add1_a_7[p] <= multi_res_high_3[p];
				add1_a_8[p] <= multi_res_high_4[p];
				add1_a_9[p] <= multi_res_high_5[p];
				add1_a_10[p] <= multi_res_high_6[p];
				add1_a_11[p] <= multi_res_high_7[p];
			end
			for(q=0;q<16;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
				add2_a_2[q] <= add1_res_2[q];
				// add2_a_3[q] <= add1_res_3[q];
			end
		end
		else if(cnt == 3'd3) begin
			cnt <= 3'd4;
			for(p=0;p<16;p=p+1) begin
				add1_a_0[p] <= multi_res_low_0[p];
				add1_a_1[p] <= multi_res_low_1[p];
				add1_a_2[p] <= multi_res_low_2[p];
				add1_a_3[p] <= multi_res_low_3[p];
				add1_a_4[p] <= multi_res_high_0[p];
				add1_a_5[p] <= multi_res_high_1[p];
				add1_a_6[p] <= multi_res_high_2[p];
				add1_a_7[p] <= multi_res_high_3[p];
				add1_a_8[p] <= multi_res_high_4[p];
				add1_a_9[p] <= multi_res_high_5[p];
				add1_a_10[p] <= multi_res_high_6[p];
				add1_a_11[p] <= multi_res_high_7[p];
			end
			for(q=0;q<16;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
				add2_a_2[q] <= add1_res_2[q];
				// add2_a_3[q] <= add1_res_3[q];
			end
			for(k=0;k<16;k=k+1) begin
				r0[(64*k)+:64] <= add2_res[k][63:0];
				r1[(64*(k+1))+:64] <= add2_res[k][127:64];
			end
		end
		else if(cnt == 3'd4) begin
			cnt <= 3'd5;
			for(q=0;q<16;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
				add2_a_2[q] <= add1_res_2[q];
				// add2_a_3[q] <= add1_res_3[q];
			end
			for(k=16;k<32;k=k+1) begin
				r0[(64*k)+:64] <= add2_res[k-16][63:0];
				r1[(64*(k+1))+:64] <= add2_res[k-16][127:64];
			end
		end
		else if(cnt == 3'd5) begin
			//cnt <= 3'd6;
			for(k=32;k<48;k=k+1) begin
				r0[(64*k)+:64] <= add2_res[k-32][63:0];
				r1[(64*(k+1))+:64] <= add2_res[k-32][127:64];
			end
		end
		//else if(cnt == 3'd6) begin
		  //cnt <= 3'd0;
		//end
	end
	end
	
	assign en_out = cnt == 3'd6;
	
	genvar i;
	generate
		for(i=0;i<16;i=i+1) begin
			multi_64_64 multi_n(multi_a[i], bi, multi_res_low_0[i], multi_res_low_1[i], multi_res_low_2[i], multi_res_low_3[i], multi_res_high_0[i], multi_res_high_1[i], multi_res_high_2[i], multi_res_high_3[i]
			, multi_res_high_4[i], multi_res_high_5[i], multi_res_high_6[i], multi_res_high_7[i]);
			add1 add1_n(add1_a_0[i], add1_a_1[i], add1_a_2[i], add1_a_3[i], add1_a_4[i], add1_a_5[i], add1_a_6[i], add1_a_7[i],
			add1_a_8[i], add1_a_9[i], add1_a_10[i], add1_a_11[i], add1_res_0[i],add1_res_1[i],add1_res_2[i]);
			add2_3_input_verison add2_n(add2_a_0[i], add2_a_1[i], add2_a_2[i], add2_res[i]);
		end
	endgenerate
endmodule