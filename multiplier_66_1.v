`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 16:06:03
// Design Name: 
// Module Name: multiplier_66_1
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

///////////////////////////////////////////////////////*from multiplier_66_1*////////////////////////////////////////////////////

module multiplier_66_1(
	input clk,
	input rst_n,
	input [65:0] a,
	input [65:0] b,
	output [63:0] res
);
	wire [21:0] wire_a [2:0];
	wire [16:0] wire_b [3:0];
	assign wire_a[0] = a[21:0];
	assign wire_a[1] = a[43:22];
	assign wire_a[2] = a[65:44];
	assign wire_b[0] = b[16:0];
	assign wire_b[1] = b[33:17];
	assign wire_b[2] = b[50:34];
	assign wire_b[3] = {2'd0, b[65:51]};
	
	reg [131:0] out[11:0];
	reg [131:0] tmp[2:0];
	reg [131:0] res_t;
	always @(posedge clk) begin
		if(~rst_n) begin
			out[0] <= 0; out[1] <= 0; out[2] <= 0; 
			out[3] <= 0; out[4] <= 0; out[5] <= 0; 
			out[6] <= 0; out[7] <= 0; out[8] <= 0;
			tmp[0] <= 0; tmp[1] <= 0; tmp[2] <= 0;
			res_t <= 0;
		end
		else begin
			out[0] <= wire_a[0]*wire_b[0];          out[1] <= (wire_a[0]*wire_b[1])<<17;    out[2] <= (wire_a[0]*wire_b[2])<<34;    out[3] <= (wire_a[0]*wire_b[3])<<51;    
			out[4] <= (wire_a[1]*wire_b[0])<<22;    out[5] <= (wire_a[1]*wire_b[1])<<39;    out[6] <= (wire_a[1]*wire_b[2])<<56;    out[7] <= (wire_a[1]*wire_b[3])<<73;
			out[8] <= (wire_a[2]*wire_b[0])<<44;    out[9] <= (wire_a[2]*wire_b[1])<<61;    out[10] <= (wire_a[2]*wire_b[2])<<78;    out[11] <= (wire_a[2]*wire_b[3])<<95;
			
			tmp[0] <= out[0]+out[1]+out[2] + out[3];
			tmp[1] <= out[4]+out[5] + out[6]+out[7];
			tmp[2] <= out[8] + out[9] + out[10] + out[11];
			
			res_t <= tmp[0] + tmp[1] + tmp[2];
		end
	end
	assign res = res_t[127:64];
endmodule

