`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2024 12:44:09
// Design Name: 
// Module Name: tx
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


module tx
( input [7 : 0] data_i, input clk_i, input ready_i, output reg tx_o );
    
    parameter tx_wait  = 4'b0000;
    parameter tx_start = 4'b0001;
    parameter tx_d0    = 4'b0010;
    parameter tx_d1    = 4'b0011;
    parameter tx_d2    = 4'b0100;
    parameter tx_d3    = 4'b0101;
    parameter tx_d4    = 4'b0110;
    parameter tx_d5    = 4'b0111;
    parameter tx_d6    = 4'b1000;
    parameter tx_d7    = 4'b1001;
    parameter tx_stop  = 4'b1010;
    
    parameter integer NDIV = 10417;
    
    reg [4 : 0] present_state = tx_start;
    reg [4 : 0] next_state;
    
    reg [7 : 0] buffor = 0;
    
    reg tx_enable = 1;
    
    reg last_tx_clk = 0;
    
    reg tx_ready = 0;
    
    wire tx_clk;
    
    div #(.NDIV(NDIV)) clock
    (clk_i, tx_enable, tx_clk);
    
    initial
    begin
        tx_o = 1;
    end
    
    always @(present_state)
    begin
    
        case(present_state)
        tx_start:   next_state = tx_d0;
        tx_d0:      next_state = tx_d1;
        tx_d1:      next_state = tx_d2;
        tx_d2:      next_state = tx_d3;
        tx_d3:      next_state = tx_d4;
        tx_d4:      next_state = tx_d5;
        tx_d5:      next_state = tx_d6;
        tx_d6:      next_state = tx_d7;
        tx_d7:      next_state = tx_stop;
        tx_stop:    next_state = tx_start;
        default:    next_state = tx_start;
        endcase
    
    end
    
    always @ (posedge clk_i)
    begin
    
        if (ready_i == 1 && present_state == tx_start)
        begin
            tx_enable = 0;
            buffor = data_i;
        end
        else if(present_state == tx_start && tx_ready == 1)
            tx_enable = 1;
        
    end
    
    always @ (posedge clk_i)
    begin
    
        if (tx_clk == 0 && last_tx_clk != tx_clk)
        begin
            last_tx_clk = tx_clk;
            if (present_state == tx_start && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = 0;
                tx_ready = 0;
            end
            else if (present_state == tx_d0 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[0];
            end
            else if (present_state == tx_d1 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[1];
            end
            else if (present_state == tx_d2 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[2];
            end
            else if (present_state == tx_d3 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[3];
            end
            else if (present_state == tx_d4 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[4];
            end
            else if (present_state == tx_d5 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[5];
            end
            else if (present_state == tx_d6 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[6];
            end
            else if (present_state == tx_d7 && ~tx_enable)
            begin
                present_state = next_state;
                tx_o = buffor[7];
            end
            else if (present_state == tx_stop)
            begin
                present_state = next_state;
                tx_o = 1;
                tx_ready = 1;
            end
            else
                present_state = tx_start;
        end
        else
            last_tx_clk = tx_clk;
    
    end
    
endmodule
