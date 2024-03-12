`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 19:10:58
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


module top_tb ( );

    reg clk_i = 0;
    reg rst_i = 0;
    reg button_hr_i = 0;
    reg button_min_i = 0;
    reg button_test_i = 0;
    
    wire [7 : 0] led7_seg_o;
    wire [7 : 0] led7_an_o;
    
    top DUT 
    (
    clk_i,
    rst_i,
    button_hr_i,
    button_min_i,
    button_test_i,
    led7_seg_o,
    led7_an_o
    );
    
    initial
    begin
        clk_i = 0;
        rst_i = 0;
    end
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
        #1_000          button_test_i = 1;
        #60_000_000     button_test_i = 0;
        #25_000_000
        #10_000_000     rst_i = 1;
        #20_000_000     rst_i = 0;
        #1_000_000      rst_i = 1;
        #60_000_000     rst_i = 0;
        #188_000_000  
    
        $finish;
    end

endmodule
