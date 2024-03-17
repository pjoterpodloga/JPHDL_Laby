`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 13:21:13
// Design Name: 
// Module Name: adder_bcd
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


module adder_bcd
(
    input [3 : 0] data_a_i,
    input [3 : 0] data_b_i,
    
    input carry_i,
    
    output [3 : 0] data_r_o,
    output carry_o
);

    wire [4 : 0] result = data_a_i + data_b_i + carry_i;
    assign data_r_o = result % 4'b1010;
    assign carry_o  = result >= 4'b1010 ? 1'b1 : 1'b0; 

endmodule
