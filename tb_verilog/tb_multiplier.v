`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/11 20:33:41
// Design Name: 
// Module Name: tb
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


module tb;

    reg clk, rst_n, en;
    reg [111:0] a;
    reg [109:0] bi;
    wire [1:0] res_i0;
    wire [107:0]res_i1;
    
    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        a = 112'hdbe90cfb52f766_dbe90cfb52f766;
        bi = 110'b00110000_00110011_00101101_00110010_11010011_10000100_11101000_00110000_00110011_00101101_00110010_11010011_10000100_111010;
        // the answer is 0x9747a7e81e0bcbb5041196d05593df4b9bb43a5b00adfc34fb76ac34aa983720934c63f77cd7f68a91b4b117ed79a6f8642c2463e7363c2fc63af2b6f9cdbe91690244d899217e9f0fe7df3ce792cab2ba854cd3057b515fca3c1713aa6da6c095b37b7c85fee2629eca68b8f7b1f963cce252fd4b4f025b1de32abb5e851a104005f8ef1e1231af53e4c488b9825fd8f6f583ecce60f91086781686fb45d8f1cd01c60a4d18f4bcc3c1cc5558daac86b8ab3f2da2b718a015a79a08dead11b8d0661a963348b0f7385b24f6d6bcd18a9b93bf330b90b7628c6a995ddd33ba1e1af1c41a2fb419168bab7f30c9fbc1422e53d1dfd340036020b1afc8322ef7004bfd6ae7e254ae88b0f1745de0973992bd9c5736df3621c0b3c487fa37c75a085bb2b30bfd1f2d5bdeca3729527dd3779095c5fe3281aef43f4c742dad0050b74ca100d7dd2703fee9fd9f996a487972fb07568d497e721f6c5bfdc71d652614e873a042076edcb4c1200708a4c5f9c3656674a230bbb7dfba65d34bcf01297a7e5e1fb5fd6c60
        #15
        rst_n = 1;
        #20
        en = 1;
        #10;
        en = 0;
        #1000;
        $finish;
        // #40
        // a = 3072'hd284de3c3a6f2853ffdac3e1bc1adfd3e4162204d7daf6404d48841b888e1a8151e4713e8edd5adba45cdfc1b162b7ea88ab136e3d9d20cfd69c39877220bcbbd14c2432bfb41f511556997223afafb5c2c5b726a5901352538569d6c28e5d3da3e2374a38435626fc0ef0937f1444c9af4dfc18bbd7eaee5a51f095d47c3c9ec19633c435eedc8a5c700d71a6c099d5e0b53837e4026c04a5b1f3767d9d4ea08075e8d1fb5316353192dbf4db7c35c2ce1ccfe2741f5ed9edd89ca7b144b7e3fd2a4a1069c2fb74270a4059bd461f8f6cf62293f774b6ebe9adf1e169976649f44ec86e859360133b552a826158aeeebbb5c8d0c513140c386d2a93afde8f6ae15eb974226d22c0a5ae1fb8835dd1e49dd5b087eb55bbc753df2db49ade74386d4b1d663d5d0e6d09a5e4910d39cd7e8f8bc45a68b46a1d65d0f6211af7cfc470a6041cf3a4e32a4657d3ca5fdb69ee28c531f4878fa0f9fec215a3b9706a9b00394458bb20883753314c923b7bb975376b3c35c2e39056501206b0034f3088;
        // en = 1;
    end
    
    always #5 clk = ~clk;

    multiplier_upper_2_bit multiplier_i0(clk,rst_n,en,a[109:0],bi,res_i0);
    multiplier_middle_bit multiplier_i1(clk,rst_n,en,a[109:0],bi,res_i1);

endmodule
