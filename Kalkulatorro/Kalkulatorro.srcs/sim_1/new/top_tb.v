`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 17:46:08
// Design Name: 
// Module Name: top_tb
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


module top_tb ();

    reg clk_i = 0;
    reg rst_i = 0;
    reg ps2_clk_i = 1;
    reg ps2_data_i = 1;
    
    wire [7 : 0] led7_seg_o;
    wire [7 : 0] led7_an_o;

    top DUT
    (
        clk_i,
        rst_i,
        
        ps2_clk_i,
        ps2_data_i,
        
        led7_seg_o,
        led7_an_o
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
        #66_666 rst_i = 1;
        #1_000 rst_i = 0;
        
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        
        #66_666
        
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        
        #66_666
              
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        
        #66_666
              
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 0;
        #66_666 ps2_data_i = 1;
        #66_666 ps2_data_i = 1;
        
        #66_666
        #66_666
        #66_666
        
        #66_666 $finish;
        
    end

endmodule
