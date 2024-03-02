`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 17:54:15
// Design Name: 
// Module Name: div_tb
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


module div_tb(

    );
    
    reg clk_i;
    reg rst_i;
    wire clk_o;
    
    div #(.NDIV(10417)) DUT
    (clk_i, rst_i, clk_o);
    
    initial
    begin
        clk_i = 0;
        rst_i = 0;
        
        #5
        #20 rst_i = 1;
        #20 rst_i = 0;
    end
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
endmodule
