`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 17:47:10
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


module top
( input clk_i, input rst_i, input RXD_i, output TXD_o );
    
    reg [7 : 0] tx_buffor;
    wire [7 : 0] rx_buffor;
    wire ready;
    
    tx tx_module
    (tx_buffor, clk_i, ready, TXD_o);
    rx rx_module
    (RXD_i, clk_i, rx_buffor, ready);
    
    always @(*)
    begin
        tx_buffor = rx_buffor + 8'h20;
    end
    
endmodule
