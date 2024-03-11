`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 17:12:50
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
    input button_hr_i,
    input button_min_i,
    input button_test_i,
    output [7 : 0] led7_seg_o,
    output [7 : 0] led7_an_o
    );
    
    wire [2 : 0] button;
    
    debounce debounce_btn_hr    (button_hr_i,   clk_i, button[2]);
    debounce debounce_btn_min   (button_hr_i,   clk_i, button[1]);
    debounce debounce_btn_test  (button_test_i, clk_i, button[0]);
    
    wire [15 : 0] seg_data;
    
    seg_con segment_controller ({{16{0}}, seg_data}, clk_i, led7_an, led7_seg_o);
    
    clock Clock (clk_i, rst_i, button[0], button[2], button[1], seg_data);
    
endmodule
