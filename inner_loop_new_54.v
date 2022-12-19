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
#(parameter Size = 3072, radix = 54)
(
	input clk,
	input rst_n,
	input [radix-1:0] bi,
	input [Size+1:0] a,
	input en,
	output reg [Size+radix+1:0] r0,// 3072+64 = 3136  3136+2=3138
	output reg [Size+radix+1:0] r1,
	output en_out
    );

	//**********************************
	//what is this meaning??????
    // wire [radix+1:0] more = 2'b11*bi;
	// wire [radix+1:0] more_bit = a[3073]?more:56'b0;
	
	// integer used for counting
	integer j,p,q,k;
	reg [2:0] cnt;
	
	// 64*16 = 1024
	reg [radix-1:0] multi_a[18:0];
	// new 54*54 multiplier parameter part and the parameter of the associated adder
	wire [44:0] multi_res_0[18:0],multi_res_1[18:0],multi_res_2[18:0],multi_res_3[18:0],multi_res_4[18:0],multi_res_5[18:0];
	reg [44:0] add1_a_0[18:0], add1_a_1[18:0], add1_a_2[18:0], add1_a_3[18:0], add1_a_4[18:0], add1_a_5[18:0];
	wire [radix*2-1:0] add1_res_0[18:0],add1_res_1[18:0];
	reg [radix*2-1:0] add2_a_0[18:0], add2_a_1[18:0];
	wire [radix*2-1:0] add2_res[18:0];
	
	always @(posedge clk) begin
		if(~rst_n) begin
			cnt <= 3'd0;
			for(j=0;j<19;j=j+1) begin
				multi_a[j] <= 0;
			end
			for(p=0;p<19;p=p+1) begin
				add1_a_0[p] <= 0;
				add1_a_1[p] <= 0;
				add1_a_2[p] <= 0;
				add1_a_3[p] <= 0;
				add1_a_4[p] <= 0;
				add1_a_5[p] <= 0;
			end
			for(q=0;q<19;q=q+1) begin
				add2_a_0[q] <= 0;
				add2_a_1[q] <= 0;
			end
	        r0 <= 0;
	        r1 <= 0;
		end
		else begin
		if(en) begin
			cnt <= 3'd1;
			for(j=0;j<19;j=j+1) begin
				multi_a[j] <= a[(radix*j)+:radix];
			end
		end
		if(cnt == 3'd1) begin
			cnt <= 3'd2;
			// r0[Size+radix+1:Size] <= more_bit;
			for(j=19;j<38;j=j+1) begin
				multi_a[j-19] <= a[(radix*j)+:radix];
			end
			for(p=0;p<19;p=p+1) begin
				add1_a_0[p] <= multi_res_0[p];
				add1_a_1[p] <= multi_res_1[p];
				add1_a_2[p] <= multi_res_2[p];
				add1_a_3[p] <= multi_res_3[p];
				add1_a_4[p] <= multi_res_4[p];
				add1_a_5[p] <= multi_res_5[p];
			end
		end
		else if(cnt == 3'd2) begin
			cnt <= 3'd3;
			for(j=38;j<57;j=j+1) begin
				if(j == 56) begin
					// special case due to the imbalance partition
					multi_a[18] <= {4'b0,a[3073:3024]};
				end
				else begin
					multi_a[j-19*2] <= a[(radix*j)+:radix];
				end
			end
			for(p=0;p<19;p=p+1) begin
				add1_a_0[p] <= multi_res_0[p];
				add1_a_1[p] <= multi_res_1[p];
				add1_a_2[p] <= multi_res_2[p];
				add1_a_3[p] <= multi_res_3[p];
				add1_a_4[p] <= multi_res_4[p];
				add1_a_5[p] <= multi_res_5[p];
			end
			for(q=0;q<19;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
			end
		end
		else if(cnt == 3'd3) begin
			cnt <= 3'd4;
			for(p=0;p<19;p=p+1) begin
				add1_a_0[p] <= multi_res_0[p];
				add1_a_1[p] <= multi_res_1[p];
				add1_a_2[p] <= multi_res_2[p];
				add1_a_3[p] <= multi_res_3[p];
				add1_a_4[p] <= multi_res_4[p];
				add1_a_5[p] <= multi_res_5[p];
			end
			for(q=0;q<19;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
			end
			for(k=0;k<19;k=k+1) begin
				r0[(radix*k)+:radix] <= add2_res[k][radix-1:0];
				r1[(radix*(k+1))+:radix] <= add2_res[k][radix*2-1:radix];
			end
		end
		else if(cnt == 3'd4) begin
			cnt <= 3'd5;
			for(q=0;q<19;q=q+1) begin
				add2_a_0[q] <= add1_res_0[q];
				add2_a_1[q] <= add1_res_1[q];
			end
			for(k=19;k<38;k=k+1) begin
				r0[(radix*k)+:radix] <= add2_res[k-19][radix-1:0];
				r1[(radix*(k+1))+:radix] <= add2_res[k-19][radix*2-1:radix];
			end
		end
		else if(cnt == 3'd5) begin
			//cnt <= 3'd6;
			for(k=38;k<57;k=k+1) begin
				if(k == 56) begin
					// special case due to the imbalance partition
					r0[(radix*k)+:radix] <= add2_res[18][radix-1:0];
					r1[3127:3078] <= add2_res[18][103:54];
				end
				else begin
					r0[(radix*k)+:radix] <= add2_res[k-38][radix-1:0];
					r1[(radix*(k+1))+:radix] <= add2_res[k-38][radix*2-1:radix];
				end
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
		for(i=0;i<19;i=i+1) begin
			multi multi_n(multi_a[i], bi, clk,multi_res_0[i], multi_res_1[i], multi_res_2[i], multi_res_3[i], multi_res_4[i], multi_res_5[i]);
			add1 add1_n(add1_a_0[i], add1_a_1[i], add1_a_2[i], add1_a_3[i], add1_a_4[i], add1_a_5[i],add1_res_0[i],add1_res_1[i]);
			add2_adder_2 add2_n(add2_a_0[i], add2_a_1[i], add2_res[i]);
		end
	endgenerate
endmodule