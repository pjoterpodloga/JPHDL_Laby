`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 13:06:17
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


module top_tb(

    );
    
    reg clk_i = 0;
    reg rst_i = 0;
    wire led_o;
    
    top #( 3 ) DUT ( .clk_i (clk_i), .rst_i (rst_i), .led_o (led_o));
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
    
        clk_i = 0;
        rst_i = 0;
        
        #5 rst_i = 1;
        #5 rst_i = 0;
        #90 
        #10$finish; 
    end
    
endmodule
