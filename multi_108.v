module multi
#(parameter radix = 108)
(
	input [radix-1:0] a,
	input [radix-1:0] b,
    input clk,
	output [44:0] res_0,
	output [44:0] res_1,
	output [44:0] res_2,
	output [44:0] res_3,
	output [44:0] res_4,
	output [44:0] res_5,
    output [44:0] res_6,
	output [44:0] res_7,
	output [44:0] res_8,
	output [44:0] res_9,
	output [44:0] res_10,
	output [44:0] res_11,
    output [44:0] res_12,
	output [44:0] res_13,
	output [44:0] res_14,
	output [44:0] res_15,
	output [44:0] res_16,
	output [44:0] res_17,
    output [44:0] res_18,
	output [44:0] res_19,
	output [44:0] res_20,
	output [44:0] res_21,
	output [44:0] res_22,
	output [44:0] res_23
);
    
    // this part needs to be changed based on the radix
	wire [26:0] wire_a [3:0];
	wire [17:0] wire_b [5:0];
    wire [44:0] result [23:0];
	assign wire_a[0] = a[26:0];
	assign wire_a[1] = a[53:27];
    assign wire_a[2] = a[80:54];
	assign wire_a[3] = a[107:81];
	assign wire_b[0] = b[17:0];
	assign wire_b[1] = b[35:18];
	assign wire_b[2] = b[53:36];
    assign wire_b[3] = b[71:54];
	assign wire_b[4] = b[89:72];
	assign wire_b[5] = b[107:90];

    /***************************************/
    assign res_0 = result[0];
    assign res_1 = result[1];
    assign res_2 = result[2];
    assign res_3 = result[3];
    assign res_4 = result[4];
    assign res_5 = result[5];
    assign res_6 = result[6];
    assign res_7 = result[7];
    assign res_8 = result[8];
    assign res_9 = result[9];
    assign res_10 = result[10];
    assign res_11 = result[11];
    assign res_12 = result[12];
    assign res_13 = result[13];
    assign res_14 = result[14];
    assign res_15 = result[15];
    assign res_16 = result[16];
    assign res_17 = result[17];
    assign res_18 = result[18];
    assign res_19 = result[19];
    assign res_20 = result[20];
    assign res_21 = result[21];
    assign res_22 = result[22];
    assign res_23 = result[23];

     genvar i;
     generate
         for(i=0;i<6;i=i+1) begin: dsp_generate
             dsp_macro_0 inst_dsp_0(
                 .CLK(clk),
                 .A(wire_a[0]),
                 .B(wire_b[i]),
                 .P({result[i]}));

             dsp_macro_0 inst_dsp_1(
                 .CLK(clk),
                 .A(wire_a[1]),
                 .B(wire_b[i]),
                 .P({result[i+6]}));

             dsp_macro_0 inst_dsp_2(
                 .CLK(clk),
                 .A(wire_a[2]),
                 .B(wire_b[i]),
                 .P({result[i+12]}));

             dsp_macro_0 inst_dsp_3(
                 .CLK(clk),
                 .A(wire_a[3]),
                 .B(wire_b[i]),
                 .P({result[i+18]}));
         end
     endgenerate
    
	//original code(DSP slice usage is not well-scheduled)
    // assign res_0 = wire_a[0]*wire_b[0];
	// assign res_1 = wire_a[0]*wire_b[1];      
	// assign res_2 = wire_a[0]*wire_b[2];      
	// assign res_3 = wire_a[1]*wire_b[0];
	// assign res_4 = wire_a[1]*wire_b[1];    
	// assign res_5 = wire_a[1]*wire_b[2];    
endmodule