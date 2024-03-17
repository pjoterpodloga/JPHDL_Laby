`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 15:33:32
// Design Name: 
// Module Name: calculator_tb
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


module calculator_tb ();

    reg clk_i = 0;
    reg rst_i = 0;
    
    reg [3 : 0] data_i = 4'b0000;
    reg data_ready = 1'b0;
    
    wire [31 : 0] data_o;
    
    calculator DUT
    (
        clk_i,
        rst_i,
        data_i,
        data_ready,
        data_o
    );
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
        #10 data_i = 4'b0001;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1010;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b0001;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1010;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b0010;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1010;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b0100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1010;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b0100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10 data_i = 4'b1100;
        #10 data_ready = 1'b1;
        #10 data_ready = 1'b0;
        #10
        #10
        $finish;
    end

endmodule
