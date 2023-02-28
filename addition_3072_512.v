`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 10:31:29
// Design Name: 
// Module Name: addition_new
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

/////////////////////////////////////////////*from addition_new*//////////////////////////////////////

module addition_3072_256
#(parameter Size_add = 512*6, Size_c0 = 6,block = 512)
(
    input [Size_add-1:0] a,
    input [Size_add-1:0] b,
    input clk,
    input rst_n,
    input en,
    output [Size_add-1:0] c,
    output reg en_out
    );
    
    reg [block-1:0] reg_c[Size_c0-1:0];
    assign c = {reg_c[5], reg_c[4], reg_c[3], reg_c[2], reg_c[1], reg_c[0]};
    wire [block:0] cout[Size_c0-1:0];
    reg [block:0] c_0[Size_c0-1:0];
    reg [block:0] c_1[Size_c0-1:0];
    
    
    reg cin;
    reg [1:0] flag;
    integer i;
    always @(posedge clk) begin
        if(~rst_n) begin
            for(i=0;i<Size_c0;i=i+1) begin
                reg_c[i] = 0;
            end
        end
        else if(flag==2'b11) begin
            reg_c[0] = c_0[0][block-1:0];
            cin = c_0[0][block];
            for(i=1;i<Size_c0;i=i+1) begin
                if(cin==1) begin
                    reg_c[i] = c_1[i][block-1:0];
                    cin = c_1[i][block];
                end
                else begin
                    reg_c[i] = c_0[i][block-1:0];
                    cin = c_0[i][block];
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if(~rst_n) begin
            en_out <= 0;
        end
        else if(flag==2'b11) begin
            en_out <= 1;
        end
        else begin
            en_out <= 0;
        end
    end
    
    integer j;
    always @(posedge clk) begin
        if(~rst_n) begin
            flag <= 2'b00;
            for(j=0;j<Size_c0;j=j+1) begin
                c_0[j] <= 1025'b0;
            end
        end
        else if(en) begin
            for(j=0;j<Size_c0;j=j+1) begin
                c_0[j] <= cout[j];
            end
            flag <= 2'b01;
        end
        else if(flag==2'b01) begin
            for(j=0;j<Size_c0;j=j+1) begin
                c_1[j] <= cout[j];
            end
            flag <= 2'b11;
        end
        else if(flag==2'b11) begin
            flag <= 2'b00;
        end
    end
    
    genvar p;
    generate
        for(p=0;p<Size_c0;p=p+1) begin
            unit_adder unit_adder_0(a[block*p+:block], b[block*p+:block], flag[0], cout[p]);
        end
    endgenerate 
endmodule

module unit_adder(
    input [511:0] a,
    input [511:0] b,
    input cin,
    output [512:0] c
);
    assign c = a+b+cin;
endmodule
