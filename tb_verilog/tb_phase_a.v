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


module tb(

    );
    reg clk, rst_n, en;
    reg [3071:0] a,m;
    reg [3073:0] m_n;
    reg [109:0] m_prime;
    wire [3071:0] new_a;
    wire en_out;
    
    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        a = 3072'h5537b809d650de8821a83a5433a9d61aede0b5920116118d86fb93a8d61ff5a55a3e1a86a9120ba88af0ff4819be8672a58ecbc4400842af1066a7b2e35e526d9ab97bd64db7bff40899184841441aa17a2d7841cf20bc9a5fc943298506d301af280f381f7926c35def357682db8c4db8efe60f0aa935118ab780d2973963903eb6d14bb6540990f80c8061362db2be2bf1cc084dce716c58cca95c5cd0c1b936019cd4759e88ad73f4da76a03fbeef68cb9e02460732361921f86cce6536ba073754de30ed0e06ed36943c5ec050f7ddd4257fbb5af45a6f419c93f11cd49134357a0be4edc9ec3ca2f8b87afa9fa492ab0d79195a0fee32d288531fef019fa0c99c50fed25f253cb31035ef94ecbf2d1565bdc8cc519313cbef7757b04f50f8ca834effd0688af300f3659a9447316b59e67540d31c8be01cb54ecae0e8ca60cf668014db967669e48796ecd0807113b29d0a42eb574f2e554879c44eb5d200585ffbd15b31f5f7a0a3a557a31bc8400bf88f4748907725c7be2d13da5531;
        m = 3072'hdc85279b3f9f6f56ed70ec798632ff7f62829f9aed27ce9b97bf748a8768c48364a1f91bacfdd03d5190b29661de1d3d206b56c498e67cafbee993abecc98f843cdc450214c40389a03b958e0fcceeacdc05af7438ba1a595c3e7931966a71299fbaedda383a619433cc35a51da18d6acc030a84b25333a327328ca85b44e416ccb17ae7676587791240ca9c49d1cf8218a83e6560bd24eeca83e1bae2e7ea0d8f7ad7f578fb28cc66ea66547c8b99954ca77217d79e0d40cf15e92a1da2bc22c1ff04bab3064e192857ae677f43bf3f1e52b96d702283a7dc9988476fa7ad499f015f0dd2b5d4422762d34c42635dbc83c14fdedef8f76bbe1ad03d2c60075887f5811f7765d9ae7d4201524cd355e8d8e73925526c356eb8f676af0217a64b74cb4ad6525fc9f7fca40ef0ee70f11022804bd7bf7c2321c9505c6ab348082a84955d0a38f8dda6e8c347268de733f4adf6475bf4dbf88443f43365070d2d21c472527036376a0baf155d8bf192f20254882416f304ad08992cc4e36483d004;
        m_n = 3074'h3237ad864c06090a9128f138679cd00809d7d606512d8316468408b7578973b7c9b5e06e453022fc2ae6f4d699e21e2c2df94a93b6719835041166c541336707bc323bafdeb3bfc765fc46a71f033115323fa508bc745e5a6a3c186ce69958ed660451225c7c59e6bcc33ca5ae25e729533fcf57b4daccc5cd8cd7357a4bb1be9334e8518989a7886edbf3563b62e307de757c19a9f42db11357c1e451d1815f27085280a8704d733991599ab8374666ab3588de82861f2bf30ea16d5e25d43dd3e00fb454cf9b1e6d7a8519880bc40c0e1ad46928fdd7c58236677b8905852b660fea0f22d4a2bbdd89d2cb3bd9ca2437c3eb0212107089441e52fc2d39ff8a7780a7ee0889a265182bdfeadb32caa172718c6daad93ca9147098950fde859b48b34b529ada03608035bf10f118f0eefdd7fb4284083dcde36afa3954cb7f7d57b6aa2f5c7072259173cb8d97218cc0b5209b8a40b24077bbc0bcc9af8f2d2de3b8dad8fc9c895f450eaa2740e6d0dfdab77dbe90cfb52f766d33b1c9b7c2ffc;
        m_prime = 80'b00110000_00110011_00101101_00110010_11010011_10000100_11101000_00110000_00110011_00101101;
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
    phase_a phase_a(clk, rst_n, a, m, m_n, m_prime, en, new_a, en_out);
endmodule
