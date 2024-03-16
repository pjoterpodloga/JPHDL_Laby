`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 18:46:49
// Design Name: 
// Module Name: clock
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


module clock
    (
    input clk_i,
    input rst_i,
    input test_i,
    input hour_i,
    input minute_i,
    output [15 : 0] data_o
    );
    
    reg [3 : 0] hourD = 0;
    reg [3 : 0] hourU = 0;
    reg [3 : 0] minuteD = 0;
    reg [3 : 0] minuteU = 0;
    
    wire clk_x1;
    wire clk_x1000;
    wire clk_clock;
    
    reg switch_div = 0;
    
    reg last_clk_clock = 0;
    
    div #(100_000_000)  div_x1     (clk_i, 1'b0, clk_x1);
    div #(100_00)      div_x1000   (clk_i, 1'b0, clk_x1000);
    
    assign clk_clock = switch_div ? clk_x1000 : clk_x1;
    
    initial
    begin
        hourD <= 0;
        hourU <= 0;
        minuteD <= 0;
        minuteU <= 0;

    end
    
    always @ (posedge test_i)
    begin
        switch_div = ~switch_div;
    end
    
    assign data_o[3  : 0]   = minuteU;
    assign data_o[7  : 4]   = minuteD;
    assign data_o[11 : 8]   = hourU;
    assign data_o[15 : 12]  = hourD;
    
    always @ (posedge clk_clock, posedge rst_i)
    begin
    
        if (rst_i)
        begin
            minuteU <= 0;
            minuteD <= 0;
            hourU <= 0;
            hourD <= 0;
        end
    
        else if (clk_clock)
        begin
        
            minuteU = minuteU + 1;
            
            if (minuteU == 10)
            begin
                minuteU = 0;
                minuteD = minuteD + 1;
            end
            
            if (minuteD == 6)
            begin
                minuteD = 0;
                hourU = hourU + 1;
            end
            
            if (hourU == 10)
            begin
                hourU = 0;
                hourD = hourD + 1;
            end
            
            if (hourD == 2 && hourU == 4)
            begin
                hourD = 0;
                hourU = 0;
            end
            
        end
        
    end
    
endmodule
