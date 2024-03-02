`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 12:40:39
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
    
    reg [15 : 0] sw_i;
    wire [7 : 0] an_o;
    wire [7 : 0] seg_o;
    
    top DUT (
    .sw_i (sw_i),
    .an_o (an_o),
    .seg_o (seg_o)
    );
    
    initial
    begin
    sw_i = 0;
    
    #5 sw_i = 16'b0000_0000_0000_0000;  //E
    #5 sw_i = 16'b0000_0000_0000_0001;  //O
    #5 sw_i = 16'b0000_0000_0000_0011;  //E
    #5 sw_i = 16'b0000_0000_0001_1100;  //O
    #5 sw_i = 16'b0000_1111_1110_0000;  //O
    #5 sw_i = 16'b1111_0000_0000_0000;  //E
    #5 sw_i = 16'b1000_0010_0100_0100;  //E
    #5 sw_i = 16'b0101_0100_0000_0100;  //E
    #5 $finish;
    end
    
endmodule
