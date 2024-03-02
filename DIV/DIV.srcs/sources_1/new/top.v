`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 12:53:17
// Design Name: 
// Module Name: top
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


module top #(parameter NDIV = 2)
(
    clk_i,
    rst_i,
    led_o
);
    
    input clk_i;
    input rst_i;
    output reg led_o = 0;
    
    integer counter = 0;
    
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
            led_o = 0;
        else if (counter == NDIV)
        begin
            led_o = 1;
            counter = 0;
        end
        else if (rst_i)
            led_o = 0;
    
    end
    
endmodule
