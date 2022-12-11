module multi
(#parameter radix = 54)
(
	input [radix-1:0] a,
	input [radix-1:0] b,
    input clk,
	output [44:0] res_0,
	output [44:0] res_1,
	output [44:0] res_2,
	output [44:0] res_3,
	output [44:0] res_4,
	output [44:0] res_5
);
	wire [26:0] wire_a [1:0];
	wire [17:0] wire_b [2:0];
    wire [44:0] result [5:0];
	assign wire_a[0] = a[26:0];
	assign wire_a[1] = a[53:27];
	assign wire_b[0] = b[17:0];
	assign wire_b[1] = b[35:18];
	assign wire_b[2] = b[53:36];

    assign res_0 = result[0];
    assign res_1 = result[1];
    assign res_2 = result[2];
    assign res_3 = result[3];
    assign res_4 = result[4];
    assign res_5 = result[5];

    genvar i;
    generate
        for(i=0;i<3;i=i+1) begin: dsp_generate
            dsp_macro_0 inst_dsp_0(
                .CLK(clk),
                .A(wire_a[0]),
                .B(wire_b[i]),
                .P({result[i]}));

            dsp_macro_0 inst_dsp_1(
                .CLK(clk),
                .A(wire_a[1]),
                .B(wire_b[i]),
                .P({result[i+3]}));
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