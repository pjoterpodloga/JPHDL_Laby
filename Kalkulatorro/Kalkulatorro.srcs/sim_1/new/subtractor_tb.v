`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 13:55:00
// Design Name: 
// Module Name: subtractor_tb
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


module subtractor_tb ();


    reg [3 : 0] data_a_i = 16'h0000;
    reg [3 : 0] data_b_i = 16'h0000;
    
    reg borrow_i = 1'b0;
    
    wire [3 : 0] data_r_o;
    wire borrow_o;
    
    subtractor_bcd DUT
    (
        data_a_i,
        data_b_i,
        borrow_i,
        data_r_o,
        borrow_o
    );
    
    always
    begin
    
        #10 data_a_i = 4'h0; data_b_i = 4'h0; borrow_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h0; borrow_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h1; borrow_i = 1'b0;
        #10 data_a_i = 4'h1; data_b_i = 4'h1; borrow_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h9; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h9; borrow_i = 1'b1;
        #10 data_a_i = 4'h8; data_b_i = 4'h9; borrow_i = 1'b1;
        #10 data_a_i = 4'h7; data_b_i = 4'h9; borrow_i = 1'b1;
        #10 data_a_i = 4'h6; data_b_i = 4'h9; borrow_i = 1'b1;
        #10 data_a_i = 4'h5; data_b_i = 4'h9; borrow_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h8; borrow_i = 1'b1;
        #10 data_a_i = 4'h9; data_b_i = 4'h8; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h7; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h6; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h5; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h4; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h3; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h2; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h1; borrow_i = 1'b0;
        #10 data_a_i = 4'h9; data_b_i = 4'h0; borrow_i = 1'b0;
        #10
        $finish;
    end

endmodule
