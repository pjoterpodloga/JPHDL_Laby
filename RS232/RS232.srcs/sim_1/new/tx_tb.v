`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2024 13:30:55
// Design Name: 
// Module Name: tx_tb
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


module tx_tb(

    );
    
    parameter [7 : 0] data = 8'b0000_0001;
    
    reg [7 : 0] data_i = 0;
    reg clk_i = 0;
    reg ready_i = 0;
    
    wire tx_o;
    
    tx DUT 
    (data_i, clk_i, ready_i, tx_o);
    
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
        data_i = data;
        clk_i = 0;
        ready_i = 0;
        
    #10000      ready_i = 1;
    #104166     ready_i = 0;
    #3_000_000 $finish;
    end
    
endmodule
