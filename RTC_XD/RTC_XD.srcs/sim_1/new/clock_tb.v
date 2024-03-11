`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 19:11:32
// Design Name: 
// Module Name: clock_tb
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


module clock_tb ( );

    reg clk_i = 0;
    reg rst_i = 0;
    reg button_hr_i = 0;
    reg button_min_i = 0;
    reg button_test_i = 0;

    wire [15 : 0] data_o;

    clock DUT 
    (
    clk_i, 
    rst_i, 
    button_test_i, 
    button_hr_i, 
    button_test_i, 
    data_o
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
        #1_000 button_test_i = 1;
        #1_000 button_test_i = 0;
        #20_000_000  rst_i = 1;
        #1_000      rst_i = 0;
        #20_000_000
        $finish;
    end

endmodule
