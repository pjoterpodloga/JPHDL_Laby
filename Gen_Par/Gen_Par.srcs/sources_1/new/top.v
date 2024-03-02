`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 12:20:57
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


module top(
    sw_i,
    an_o,
    seg_o
    );
    
    input [15 : 0] sw_i;
    output reg [7 : 0] an_o;
    output reg [7 : 0] seg_o;
    
    reg parity;
    
    always @ (*)
    begin
    
        an_o <= 1'b0000_0001;
    
        parity <= ^sw_i;
        
        case(parity)
        1'b0    : seg_o <= 8'b10011110;
        1'b1    : seg_o <= 8'b11111100;
        default : seg_o <= 8'b11111110;
        endcase
    end
    
endmodule
