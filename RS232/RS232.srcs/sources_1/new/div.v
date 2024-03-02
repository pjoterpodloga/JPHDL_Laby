`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 17:47:59
// Design Name: 
// Module Name: div
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


module div
#( NDIV = 1)
( input clk_i, input rst_i, output reg clk_o);
    
    integer counter = 0;
    
    initial
    begin
        clk_o = 0;
    end
    
    always @ (posedge clk_i or posedge rst_i)
    begin
    
        if (rst_i)
            counter = 0;
        else
            counter = counter + 1;

    end
    
    always @ (*)
    begin
    
        if (counter == NDIV/2)
            clk_o = 0;
        else if (counter == NDIV)
        begin
            clk_o = 1;
            counter = 0;
        end
        else if (rst_i)
            clk_o = 0;
    
    end

endmodule
