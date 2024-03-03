`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2024 14:25:06
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


module top_tb(

    );
    
    parameter [7 : 0] data = 8'b0000_0000;
    
    reg clk_i = 0;
    reg rst_i = 0;
    reg RXD_i = 1;
    reg [7 : 0] data_tx = 0;
    
    wire TXD_o;
    
    top DUT
    (clk_i, rst_i, RXD_i, TXD_o);
    
    initial
    begin
        clk_i = 0;
        rst_i = 0;
        RXD_i = 1;
    end
    
    always
    begin
        #5 clk_i = ~clk_i;
    end
    
    initial
    begin
    #104_166
    #10_000     RXD_i = 0;
    #104_166    RXD_i = data[0];
    #104_166    RXD_i = data[1];
    #104_166    RXD_i = data[2];
    #104_166    RXD_i = data[3];
    #104_166    RXD_i = data[4];
    #104_166    RXD_i = data[5];
    #104_166    RXD_i = data[6];
    #104_166    RXD_i = data[7];
    #104_166    RXD_i = 1;
    #104_166
    #104_166    data_tx[0] = TXD_o;
    #104_166    data_tx[1] = TXD_o;
    #104_166    data_tx[2] = TXD_o;
    #104_166    data_tx[3] = TXD_o;
    #104_166    data_tx[4] = TXD_o;
    #104_166    data_tx[5] = TXD_o;
    #104_166    data_tx[6] = TXD_o;
    #104_166    data_tx[7] = TXD_o;
    #104_166
    #104_166
    #104_166
    #104_166
    #10_000     $finish;
    end
    
endmodule
