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
	input en,
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
	assign wire_b_low[1] = b[35:18];
	assign wire_b_high = b[55:36];
	
    //used for store the intermediate results
	reg [39:0] out[8:0];
	reg [mul_size*2-1:0] tmp[2:0];
	reg [mul_size*2-1:0] res_t;
	reg [2:0] cnt;

	wire [mul_size*2-1:0] wire_out[8:0];

	assign wire_out[0] = {72'b0,out[0]};
	assign wire_out[1] = {54'b0,out[1],18'b0}; 
	assign wire_out[2] = {36'b0,out[2],36'b0};
	assign wire_out[3] = {54'b0,out[3],18'b0};
	assign wire_out[4] = {36'b0,out[4],36'b0};
	assign wire_out[5] = {18'b0,out[5],54'b0};
	assign wire_out[6] = {36'b0,out[6],36'b0};
	assign wire_out[7] = {18'b0,out[7],54'b0};
	assign wire_out[8] = {out[8],72'b0};
	
	// multiply, each cost a dsp slice
	always @(posedge clk) begin
		if(~rst_n) begin
			out[0] <= 0; out[1] <= 0; out[2] <= 0; 
			out[3] <= 0; out[4] <= 0; out[5] <= 0; 
			out[6] <= 0; out[7] <= 0; out[8] <= 0;
			res_t <= 0;
			cnt <= 0;
		end
		else begin
			if(en) begin
				cnt <= 3'd1;
				out[0] <= wire_a_low[0]*wire_b_low[0];
				out[1] <= wire_a_low[0]*wire_b_low[1];
				out[2] <= wire_a_low[0]*wire_b_high;
				out[3] <= wire_a_low[1]*wire_b_low[0];
				out[4] <= wire_a_low[1]*wire_b_low[1];
				out[5] <= wire_a_low[1]*wire_b_high;
				out[6] <= wire_a_high*wire_b_low[0];
				out[7] <= wire_a_high*wire_b_low[1];
				out[8] <= wire_a_high*wire_b_high; 
			end
			else if(cnt == 3'd1) begin
				tmp[0] <= wire_out[0] + wire_out[1] + wire_out[2];
				tmp[1] <= wire_out[3] + wire_out[4] + wire_out[5];
				tmp[2] <= wire_out[6] + wire_out[7] + wire_out[8];
				cnt <= 3'd2;
			end
			else if(cnt == 3'd2) begin
				res_t <= tmp[0] + tmp[1] + tmp[2];
				cnt <= 0;
			end
		end
	end
	assign res = res_t[radix*2+3:radix*2+2];
endmodule



module multiplier_middle_bit
#(parameter mul_size = 56,radix = 54) 
(
	input clk,
	input rst_n,
	input en,
	input [mul_size-1:0] a,
	input [mul_size-1:0] b,
	output [radix-1:0] res
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
	assign wire_b_low[1] = b[35:18];
	assign wire_b_high = b[55:36];
	
    //used for store the intermediate results
	reg [39:0] out[8:0];
	reg [mul_size*2-1:0] tmp[2:0];
	reg [mul_size*2-1:0] res_t;
	reg [2:0] cnt;

	wire [mul_size*2-1:0] wire_out[8:0];
    
	assign wire_out[0] = {72'b0,out[0]};
	assign wire_out[1] = {54'b0,out[1],18'b0}; 
	assign wire_out[2] = {36'b0,out[2],36'b0};
	assign wire_out[3] = {54'b0,out[3],18'b0};
	assign wire_out[4] = {36'b0,out[4],36'b0};
	assign wire_out[5] = {18'b0,out[5],54'b0};
	assign wire_out[6] = {36'b0,out[6],36'b0};
	assign wire_out[7] = {18'b0,out[7],54'b0};
	assign wire_out[8] = {out[8],72'b0};

	// multiply, each cost a dsp slice
	always @(posedge clk) begin
		if(~rst_n) begin
			out[0] <= 0; out[1] <= 0; out[2] <= 0; 
			out[3] <= 0; out[4] <= 0; out[5] <= 0; 
			out[6] <= 0; out[7] <= 0; out[8] <= 0;
			res_t <= 0;
			cnt <= 0;
		end
		else begin
			if(en) begin
				cnt <= 3'd1;
				out[0] <= wire_a_low[0]*wire_b_low[0];
				out[1] <= wire_a_low[0]*wire_b_low[1];
				out[2] <= wire_a_low[0]*wire_b_high;
				out[3] <= wire_a_low[1]*wire_b_low[0];
				out[4] <= wire_a_low[1]*wire_b_low[1];
				out[5] <= wire_a_low[1]*wire_b_high;
				out[6] <= wire_a_high*wire_b_low[0];
				out[7] <= wire_a_high*wire_b_low[1];
				out[8] <= wire_a_high*wire_b_high; 
			end
			else if(cnt == 3'd1) begin
				tmp[0] <= wire_out[0] + wire_out[1] + wire_out[2];
				tmp[1] <= wire_out[3] + wire_out[4] + wire_out[5];
				tmp[2] <= wire_out[6] + wire_out[7] + wire_out[8];
				cnt <= 3'd2;
			end
			else if(cnt == 3'd2) begin
				res_t <= tmp[0] + tmp[1] + tmp[2];
				cnt <= 0;
			end
		end
	end
	assign res = res_t[radix*2-1:radix];
endmodule
