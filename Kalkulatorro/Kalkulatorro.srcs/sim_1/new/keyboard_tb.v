`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 15:57:27
// Design Name: 
// Module Name: keyboard_tb
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


module keyboard_tb ();

    reg clk_i = 0;
    reg rst_i = 0;
    reg ps2_clk_i = 1;
    reg ps2_data_i = 1;
    
    wire [3 : 0] data_o;
    wire ready;
    
    keyboard DUT 
    (
        clk_i,
        rst_i,
        ps2_clk_i,
        ps2_data_i,
        data_o,
        ready
    );
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
        #66_666
        #66_666 ps2_data_i = 0; ps2_clk_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 
        #66_666
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666
        #66_666
        #66_666 $finish;
    end

endmodule
