`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 10:45:40
// Design Name: 
// Module Name: div
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


module div #(NDIV = 2) 
(
    input clk_i,
    input rst_i,
    output reg clk_o
);
    
    integer counter = 0;
    
    
    initial
    begin
        clk_o = 0;
        counter = 0;
    end
    
    always @ (posedge clk_i, posedge rst_i)
    begin
    
        if (rst_i)
        begin
            clk_o = 0;
            counter = 0;
        end
        else if (clk_i)
        begin
            counter <= counter + 1;
            
            if (counter == NDIV/2)
            begin
                clk_o <= 0;
            end
            else if (counter == NDIV - 1)
            begin
                clk_o <= 1;
                counter <= 0;
            end
            
        end
        
    end

endmodule
