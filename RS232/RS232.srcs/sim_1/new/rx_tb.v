`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 19:01:52
// Design Name: 
// Module Name: rx_tb
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


module rx_tb(

    );
    
    reg rx_i;
    reg clk_i;
    wire [7 : 0] data_o;
    wire ready_o;
    
    parameter [7 : 0] data = 8'b1011_0101;
    
    rx DUT
    (rx_i, clk_i, data_o, ready_o);
    
    initial
    begin
        clk_i = 0;
    end
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
        rx_i = 1;
        #10000  rx_i = 0;
        #104166 rx_i = 1;
        #104166 rx_i = 0;
        #104166 rx_i = 1;
        #104166 rx_i = 1;
        #104166 rx_i = 0;
        #104166 rx_i = 1;
        #104166 rx_i = 0;
        #104166 rx_i = 1;
        #104166 rx_i = 1;
        #104166 
        #104166 $finish;
    end
    
endmodule
