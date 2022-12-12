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

module big_number_addition
#(parameter Size_add = 256*13, number_of_adder = 13,adder_size = 256)
(
    input [Size_add-1:0] a,
    input [Size_add-1:0] b,
    input clk,
    input rst_n,
    input en,
    output [Size_add-1:0] c,
    //output reg c_top,
    output reg en_out
    );
    
    wire [adder_size:0] cout[number_of_adder-1:0];
    reg [adder_size:0] c_0[number_of_adder-1:0];
    reg [adder_size:0] c_1[number_of_adder-1:0];
    
    reg [adder_size-1:0] reg_c[number_of_adder-1:0];
    assign c = {reg_c[12], reg_c[11], reg_c[10], reg_c[9], reg_c[8], reg_c[7], reg_c[6], reg_c[5], reg_c[4], reg_c[3], reg_c[2], reg_c[1], reg_c[0]};
    reg cin;        // cin stands for the carry bit
    reg [1:0] flag;     // stands for the state
    integer i,j;

    //enable signal part
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

    //*******************************************
    //the below still is a chain structure which makes this part slow?
    //the output depends on the previous data
    //*******************************************
    always @(posedge clk) begin
        if(~rst_n) begin
            for(i=0;i<number_of_adder;i=i+1) begin
                reg_c[i] = 0;
            end
        end
        else if(flag==2'b11) begin
            reg_c[0] = c_0[0][adder_size-1:0];
            cin = c_0[0][adder_size];
            for(i=1;i<number_of_adder;i=i+1) begin
                if(cin==1) begin
                    reg_c[i] = c_1[i][adder_size-1:0];
                    cin = c_1[i][adder_size];
                end
                else begin
                    reg_c[i] = c_0[i][adder_size-1:0];
                    cin = c_0[i][adder_size];
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if(~rst_n) begin
            flag <= 2'b00;
            for(j=0;j<number_of_adder;j=j+1) begin
                c_0[j] <= 257'b0;
            end
        end
        else if(en) begin
            for(j=0;j<number_of_adder;j=j+1) begin
                c_0[j] <= cout[j];
            end
            flag <= 2'b01;
        end
        else if(flag==2'b01) begin
            for(j=0;j<number_of_adder;j=j+1) begin
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
        for(p=0;p<number_of_adder;p=p+1) begin
            unit_adder unit_adder_0(a[adder_size*p+:adder_size], b[adder_size*p+:adder_size], flag[0], cout[p]);
        end
    endgenerate 
endmodule

module unit_adder
(#parameter size = 256)
(
    input [size-1:0] a,
    input [size-1:0] b,
    input cin,
    output [size:0] c
);
    assign c = a+b+cin;
endmodule