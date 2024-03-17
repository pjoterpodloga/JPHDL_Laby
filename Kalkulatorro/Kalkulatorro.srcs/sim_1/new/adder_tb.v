`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 13:35:01
// Design Name: 
// Module Name: adder_tb
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


module adder_tb ();

    reg [3 : 0] data_a_i = 4'h0;
    reg [3 : 0] data_b_i = 4'h0;
    
    reg carry_i = 1'b0;
    
    wire [3 : 0] data_r_o;
    wire carry_o;
    
    adder_bcd DUT
    (
        data_a_i,
        data_b_i,
        carry_i,
        data_r_o,
        carry_o
    );
    
    always
    begin
    
        #10 data_a_i = 4'h0; data_b_i = 4'h0; carry_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h0; carry_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h1; carry_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h1; carry_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h9; carry_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h9; carry_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h8; carry_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h7; carry_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h6; carry_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h5; carry_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h4; carry_i = 1'b1;
        #10
        $finish;
    end

endmodule
