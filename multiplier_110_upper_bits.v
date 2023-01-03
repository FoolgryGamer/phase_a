`timescale 1ns / 1ps

module multiplier_upper_2_bit
#(parameter mul_size = 110,radix = 108) 
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
	wire [24:0] wire_a [4:0];
	wire [15:0] wire_b [6:0];

	//this part needs to be change based on the partition strategy
	assign wire_a[0] = a[24:0];
	assign wire_a[1] = a[49:25];
	assign wire_a[2] = a[74:50];
	assign wire_a[3] = a[99:75];
	assign wire_a[4] = {15'b0,a[109:100]};
	assign wire_b[0] = b[15:0];
	assign wire_b[1] = b[31:16];
	assign wire_b[2] = b[47:32];
	assign wire_b[3] = b[63:48];
	assign wire_b[4] = b[79:64];
	assign wire_b[5] = b[95:80];
	assign wire_b[6] = {2'b0,b[109:96]};
	
    //used for store the intermediate results
	reg [40:0] out[34:0];
	reg [mul_size*2-1:0] tmp[5:0];
	reg [mul_size*2-1:0] res_t;
	reg [2:0] cnt;

	wire [mul_size*2-1:0] wire_out[34:0];

	assign wire_out[0] = {179'b0,out[0]};
	assign wire_out[1] = {163'b0,out[1],16'b0};
	assign wire_out[2] = {147'b0,out[2],32'b0};
	assign wire_out[3] = {131'b0,out[3],48'b0};
	assign wire_out[4] = {115'b0,out[4],64'b0};
	assign wire_out[5] = {99'b0,out[5],80'b0};
	assign wire_out[6] = {83'b0,out[6],96'b0};
	assign wire_out[7] = {154'b0,out[7],25'b0};
	assign wire_out[8] = {138'b0,out[8],41'b0};
	assign wire_out[9] = {122'b0,out[9],57'b0};
	assign wire_out[10] = {106'b0,out[10],73'b0};
	assign wire_out[11] = {90'b0,out[11],89'b0};
	assign wire_out[12] = {74'b0,out[12],105'b0};
	assign wire_out[13] = {58'b0,out[13],121'b0};
	assign wire_out[14] = {129'b0,out[14],50'b0};
	assign wire_out[15] = {113'b0,out[15],66'b0};
	assign wire_out[16] = {97'b0,out[16],82'b0};
	assign wire_out[17] = {81'b0,out[17],98'b0};
	assign wire_out[18] = {65'b0,out[18],114'b0};
	assign wire_out[19] = {49'b0,out[19],130'b0};
	assign wire_out[20] = {33'b0,out[20],146'b0};
	assign wire_out[21] = {104'b0,out[21],75'b0};
	assign wire_out[22] = {88'b0,out[22],91'b0};
	assign wire_out[23] = {72'b0,out[23],107'b0};
	assign wire_out[24] = {56'b0,out[24],123'b0};
	assign wire_out[25] = {40'b0,out[25],139'b0};
	assign wire_out[26] = {24'b0,out[26],155'b0};
	assign wire_out[27] = {8'b0,out[27],171'b0};
	assign wire_out[28] = {79'b0,out[28],100'b0};
	assign wire_out[29] = {63'b0,out[29],116'b0};
	assign wire_out[30] = {47'b0,out[30],132'b0};
	assign wire_out[31] = {31'b0,out[31],148'b0};
	assign wire_out[32] = {15'b0,out[32],164'b0};
	assign wire_out[33] = {out[33][39:0],180'b0};
	assign wire_out[34] = {out[34][23:0],196'b0};

	// multiply, each cost a dsp slice
	always @(posedge clk) begin
		if(~rst_n) begin
			out[0] <= 0;out[1] <= 0;out[2] <= 0;out[3] <= 0;out[4] <= 0;
			out[5] <= 0;out[6] <= 0;out[7] <= 0;out[8] <= 0;out[9] <= 0;     
			out[10] <= 0;out[11] <= 0;out[12] <= 0;out[13] <= 0;out[14] <= 0;
			out[15] <= 0;out[16] <= 0;out[17] <= 0;out[18] <= 0;out[19] <= 0;
			out[20] <= 0;out[21] <= 0;out[22] <= 0;out[23] <= 0;out[24] <= 0;
			out[25] <= 0;out[26] <= 0;out[27] <= 0;out[28] <= 0;out[29] <= 0;
			out[30] <= 0;out[31] <= 0;out[32] <= 0;out[33] <= 0;out[34] <= 0;
			res_t <= 0;
			cnt <= 0;
		end
		else begin
			if(en) begin
				cnt <= 3'd1;
				out[0] <= wire_a[0]*wire_b[0];
				out[1] <= wire_a[0]*wire_b[1];
				out[2] <= wire_a[0]*wire_b[2];
				out[3] <= wire_a[0]*wire_b[3];
				out[4] <= wire_a[0]*wire_b[4];
				out[5] <= wire_a[0]*wire_b[5];
				out[6] <= wire_a[0]*wire_b[6];
				out[7] <= wire_a[1]*wire_b[0];
				out[8] <= wire_a[1]*wire_b[1];
				out[9] <= wire_a[1]*wire_b[2];
				out[10] <= wire_a[1]*wire_b[3];
				out[11] <= wire_a[1]*wire_b[4];
				out[12] <= wire_a[1]*wire_b[5];
				out[13] <= wire_a[1]*wire_b[6];
				out[14] <= wire_a[2]*wire_b[0];
				out[15] <= wire_a[2]*wire_b[1];
				out[16] <= wire_a[2]*wire_b[2];
				out[17] <= wire_a[2]*wire_b[3];
				out[18] <= wire_a[2]*wire_b[4];
				out[19] <= wire_a[2]*wire_b[5];
				out[20] <= wire_a[2]*wire_b[6];
				out[21] <= wire_a[3]*wire_b[0];
				out[22] <= wire_a[3]*wire_b[1];
				out[23] <= wire_a[3]*wire_b[2];
				out[24] <= wire_a[3]*wire_b[3];
				out[25] <= wire_a[3]*wire_b[4];
				out[26] <= wire_a[3]*wire_b[5];
				out[27] <= wire_a[3]*wire_b[6];
				out[28] <= wire_a[4]*wire_b[0];
				out[29] <= wire_a[4]*wire_b[1];
				out[30] <= wire_a[4]*wire_b[2];
				out[31] <= wire_a[4]*wire_b[3];
				out[32] <= wire_a[4]*wire_b[4];
				out[33] <= wire_a[4]*wire_b[5];
				out[34] <= wire_a[4]*wire_b[6];
			end
			else if(cnt == 3'd1) begin
				tmp[0] <= wire_out[0] + wire_out[1] + wire_out[2] + wire_out[3] + wire_out[4] + wire_out[5];
				tmp[1] <= wire_out[6] + wire_out[7] + wire_out[8] + wire_out[9] + wire_out[10] + wire_out[11];
				tmp[2] <= wire_out[12] + wire_out[13] + wire_out[14] + wire_out[15] + wire_out[16] + wire_out[17];
				tmp[3] <= wire_out[18] + wire_out[19] + wire_out[20] + wire_out[21] + wire_out[22] + wire_out[23];
				tmp[4] <= wire_out[24] + wire_out[25] + wire_out[26] + wire_out[27] + wire_out[28] + wire_out[29];
				tmp[5] <= wire_out[30] + wire_out[31] + wire_out[32] + wire_out[33] + wire_out[34];
				cnt <= 3'd2;
			end
			else if(cnt == 3'd2) begin
				res_t <= tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5];
				cnt <= 0;
			end
		end
	end
	assign res = res_t[radix*2+3:radix*2+2];
endmodule
