`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 17:26:07
// Design Name: 
// Module Name: debounce_tb
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


module debounce_tb ( );

reg sw_i;
reg clk_i;

wire sw_o;

debounce #(50) sw_debounce (sw_i, clk_i, sw_o);

initial
begin
    sw_i = 0;
    clk_i = 0;
end

always
begin
    #5 clk_i = ~clk_i;
end

initial
begin
    #10_000_000
    #10_000_000 sw_i = 1;
    #12_000_000 sw_i = 0;
    #3_000_000  sw_i = 1;
    #60_000_000 sw_i = 0;
    #10_000_000 sw_i = 1;
    #20_000_000 sw_i = 0;
    #1_000_000 sw_i = 0;
    #4_000_000 sw_i = 1;
    #35_000_000 sw_i = 0;
    #100_000_000 $finish;
end

endmodule
