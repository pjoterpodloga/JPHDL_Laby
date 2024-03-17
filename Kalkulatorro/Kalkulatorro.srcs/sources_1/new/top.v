`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 10:45:23
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
(
    input clk_i,
    input rst_i,
    input ps2_clk_i,
    input ps2_data_i,
    
    output [7 : 0] led7_seg_o,
    output [7 : 0] led7_an_o
);

    wire [31 : 0] seg_data;

    seg_con segment_controller ({16'h0000, seg_data}, clk_i, rst_i, led7_an_o, led7_seg_o);
    
    wire [3 : 0] kb_data;
    wire kb_ready;
    
    keyboard kb (clk_i, rst_i, ps2_clk_i, ps2_data_i, kb_data, kb_ready);
    
    calculator calc (clk_i, rst_i, kb_data, kb_ready, seg_data);

endmodule
