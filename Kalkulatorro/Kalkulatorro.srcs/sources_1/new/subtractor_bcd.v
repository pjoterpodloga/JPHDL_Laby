`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 13:32:44
// Design Name: 
// Module Name: subtractor_bcd
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


module subtractor_bcd
(
    input [3 : 0] data_a_i,
    input [3 : 0] data_b_i,
    
    input borrow_i,
    
    output [3 : 0] data_r_o,
    output borrow_o
);
    
    wire [4 : 0] result = (data_a_i + (~{1'b0, data_b_i} + 1'b1) - borrow_i);
    
    assign data_r_o = result[3] ? 4'b1010 - (~(result[3 : 0]) + 1'b1) : result[3 : 0];
    assign borrow_o = result[3];

endmodule
