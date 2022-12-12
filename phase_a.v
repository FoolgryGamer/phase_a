`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/02 15:52:28
// Design Name: 
// Module Name: phase_a
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

///////////////////////////////////////////////////*from process_a_pipeline_test_2_copy*//////////////////////////////////////////////////

module phase_a
#(parameter Size = 3072, Size_bi = 64, Size_log = 8, Size_add = 256*13)
(
    input clk,
    input rst_n,
    input [Size-1:0] a,
    input [Size-1:0] m,
    input [Size+1:0] m_n,
    input [65:0] m_prime,
    input en,
    output reg [Size-1:0] new_a,
    output en_out
    );
    /******************************en rising edge******************************/
    reg data_in0;
    reg data_in1;
    assign en_rising_edge=data_in0&~data_in1;

    always@(posedge clk or negedge rst_n)begin 
        if(rst_n==1'b0)begin 
            data_in0<=0;
            data_in1<=0;
        end
        else begin 
            data_in0<=en;
            data_in1<=data_in0;
        end
    end
    /*******************************************************************************/
    reg [Size+Size_bi+1:0] reg_a, reg_a_1;
    reg [65:0] reg_m_prime;
    reg [2:0] cnt_0;
    reg [2:0] cnt_1;
    reg [2:0] cnt_2;
    reg [2:0] cnt_3;
    reg [2:0] cnt_4;
    
    reg [131:0] reg_im;
    wire [1:0] res_i0;
    wire [63:0] res_i1;
    wire [63:0] p_t0 = res_i0+res_i1;
    wire [64:0] p_t1 = res_i0+res_i1+1;
    wire [63:0] p = p_t1[64]?p_t0:p_t1[63:0];
    //reg p_top;
    reg en_inner_loop;
    reg [63:0] reg_bi_inner_loop;
    wire [Size+Size_bi+1:0] res_r0, res_r1;
    wire en_out_inner_loop;
    reg [Size+Size_bi+Size_log-1:0] a_adder, b_adder, cin_adder;
    wire [Size+Size_bi+Size_log-1:0] s_adder, c_adder;
    reg en_addition_0;
    wire [Size_add-1:0] c_addition_0;
    wire  en_out_addition_0;
    reg en_addition_1;
    wire [Size_add-1:0] c_addition_1;
    wire  en_out_addition_1;
    reg [Size_add-1:0] b_addition_1;
    //wire [Size_add-1:0] c_addition_2;
    //wire en_out_addition_2;
    reg [Size+1:0] c0;

    always @(posedge clk) begin
        if(~rst_n) begin
            reg_a <= 0;
            reg_im <= 0; //p_top <= 0;
            en_inner_loop <= 0; reg_bi_inner_loop <= 0;
            a_adder <= 0; b_adder <= 0; cin_adder <= 0; 
            en_addition_0 <= 0;
            en_addition_1 <= 0;
            c0 <= 0;
        end
        else begin
            if(en_rising_edge) begin
            reg_m_prime <= m_prime;
            reg_im <= {2'b0, a[(Size-1)-:130]};
            end
            if(cnt_0 == 3'd3) begin
                en_inner_loop <= 1'b1;
                reg_a <= {2'd0, a, 64'd0};
            end
            else if(cnt_0 == 3'd4) begin
                en_inner_loop <= 1'b0;
                //p_top <= p[64];
            end
            if(cnt_1 == 3'd3) begin
                reg_a_1 <= reg_a;
            end
            if(cnt_2 == 3'd1) begin  
                a_adder <= {6'd0,reg_a_1};
                b_adder <= {6'd0,res_r0};
                cin_adder <= {6'd0,res_r1};
                en_addition_0 <= 1'b1;
            end
            else if(cnt_2 == 3'd2) begin  
                en_addition_0 <= 1'b0;
            end
            if(cnt_3 == 3'd1) begin             
                if(c_addition_0[3073]) begin
                    b_addition_1 <= {256'd0, m};
                end
                else begin
                    b_addition_1 <= {254'd0, m_n};
                end
                en_addition_1 <= 1'b1;
            end
            else if(cnt_3 == 3'd2) begin       
                c0 <= c_addition_0[Size+1:0];
                en_addition_1 <= 1'b0;
            end
        end
    end

    assign en_out = cnt_4 == 3'd3;

    always @(posedge clk) begin
        if(~rst_n) begin
            cnt_0 <= 3'd0;
        end
        else if(en_rising_edge) begin
            cnt_0 <= 3'd1;
        end
        else if(cnt_0 > 3'd0 && cnt_0 < 3'd4) begin
            cnt_0 <= cnt_0 + 1'b1;
        end
        else if(cnt_0 == 3'd4) begin
            cnt_0 <= 3'd0;
        end
    end
    always @(posedge clk) begin
        if(~rst_n) begin
            cnt_1 <= 3'd0;
        end
        else if(cnt_0 == 3'd4) begin
            cnt_1 <= 3'd1;
        end
        else if(cnt_1 > 3'd0 && cnt_1 < 3'd5) begin
            cnt_1 <= cnt_1 + 1'b1;
        end
        else if(cnt_1 == 3'd5) begin
            cnt_1 <= 3'd0;
        end
    end
    always @(posedge clk) begin
        if(~rst_n) begin
            cnt_2 <= 3'd0;
        end
        else if(cnt_1 == 3'd5) begin
            cnt_2 <= 3'd1;
        end
        else if(cnt_2 > 3'd0 && cnt_2 < 3'd4) begin
            cnt_2 <= cnt_2 + 1'b1;
        end
        else if(cnt_2 == 3'd4) begin
            cnt_2 <= 3'd0;
        end
    end
    always @(posedge clk) begin
        if(~rst_n) begin
            cnt_3 <= 3'd0;
        end
        else if(cnt_2 == 3'd4) begin
            cnt_3 <= 3'd1;
        end
        else if(cnt_3 > 3'd0 && cnt_3 < 3'd2) begin
            cnt_3 <= cnt_3 + 1'b1;
        end
        else if(cnt_3 == 3'd2) begin
            cnt_3 <= 3'd0;
        end
    end
    always @(posedge clk) begin
        if(~rst_n) begin
            cnt_4 <= 3'd0;
        end
        else if(cnt_3 == 3'd2) begin
            cnt_4 <= 3'd1;
        end
        else if(cnt_4 > 3'd0 && cnt_4 < 3'd3) begin
            cnt_4 <= cnt_4 + 1'b1;
        end
        else if(cnt_4 == 3'd3) begin
            cnt_4 <= 3'd0;
        end
    end

    always @(*) begin
        case (cnt_4)
            3'd3: new_a = c_addition_1[3073]?c0:c_addition_1[3071:0];//c_addition_1[3073]?c0[3071:0]:(c_addition_2[3073]?c_addition_1[3071:0]:c_addition_2[3071:0]);
            default: ;
        endcase
    end

    //cnt_0
    multiplier_66 multiplier_66_i0(clk,rst_n,reg_im[65:0],reg_m_prime,res_i0);
    multiplier_66_1 multiplier_66_i1(clk,rst_n,reg_im[131:66],reg_m_prime,res_i1);
    //cnt_1
    inner_loop_new inner_loop_new(clk, rst_n, p[63:0], m_n, en_inner_loop, res_r0, res_r1, en_out_inner_loop);
    //cnt_2
    full_adder full_adder(a_adder,b_adder,cin_adder,s_adder,c_adder);
    //cnt_3    big number addition
    addition_new addition_new_0({184'd0, s_adder}, {183'd0, c_adder, 1'd0},  clk, rst_n, en_addition_0, c_addition_0, en_out_addition_0);
    //cnt_4
    addition_new addition_new_1(c_addition_0, b_addition_1,  clk, rst_n, en_addition_1, c_addition_1,  en_out_addition_1);
    //addition_new addition_new_2(c_addition_0, {253'd0, m_n,1'd0},  clk, rst_n, en_addition_1, c_addition_2,  en_out_addition_2);
endmodule
