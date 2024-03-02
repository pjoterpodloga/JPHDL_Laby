`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2024 18:13:52
// Design Name: 
// Module Name: rx
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


module rx
( input rx_i, input clk_i, output reg [7 : 0] data_o, output reg ready_o );
    
    parameter rx_wait  = 4'b0000;
    parameter rx_start = 4'b0001;
    parameter rx_d0    = 4'b0010;
    parameter rx_d1    = 4'b0011;
    parameter rx_d2    = 4'b0100;
    parameter rx_d3    = 4'b0101;
    parameter rx_d4    = 4'b0110;
    parameter rx_d5    = 4'b0111;
    parameter rx_d6    = 4'b1000;
    parameter rx_d7    = 4'b1001;
    parameter rx_stop  = 4'b1010;
    
    parameter integer NDIV = 10417;
    
    reg [4 : 0] present_state = rx_start;
    reg [4 : 0] next_state;
    
    reg [7 : 0] buffor = 0;
    
    reg rx_enable = 1;
    
    wire rx_clk;
    
    div #(.NDIV(NDIV)) clock
    (clk_i, rx_enable, rx_clk);
    
    initial
    begin
        data_o = 0;
        ready_o = 0;
    end
    
    always @(present_state)
    begin
    
        case(present_state)
        rx_start:   next_state = rx_d0;
        rx_d0:      next_state = rx_d1;
        rx_d1:      next_state = rx_d2;
        rx_d2:      next_state = rx_d3;
        rx_d3:      next_state = rx_d4;
        rx_d4:      next_state = rx_d5;
        rx_d5:      next_state = rx_d6;
        rx_d6:      next_state = rx_d7;
        rx_d7:      next_state = rx_stop;
        rx_stop:    next_state = rx_start;
        default:    next_state = rx_start;
        endcase
    
    end
    
    always @ (posedge clk_i)
    begin
    
        if (rx_i == 0 && present_state == rx_start)
            rx_enable = 0;
            
        else if (ready_o == 1)
            rx_enable = 1;
        
    end
    
    always @ (posedge rx_clk)
    begin
    
        if (rx_i == 1 && present_state == rx_start && ~rx_enable)
            present_state = next_state;
        else if (present_state == rx_d0 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[0] = rx_i;
        end
        else if (present_state == rx_d1 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[1] = rx_i;
        end
        else if (present_state == rx_d2 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[2] = rx_i;
        end
        else if (present_state == rx_d3 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[3] = rx_i;
        end
        else if (present_state == rx_d4 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[4] = rx_i;
        end
        else if (present_state == rx_d5 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[5] = rx_i;
        end
        else if (present_state == rx_d6 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[6] = rx_i;
        end
        else if (present_state == rx_d7 && ~rx_enable)
        begin
            present_state = next_state;
            buffor[7] = rx_i;
        end
        else if (rx_i == 1 && present_state == rx_stop)
        begin
            present_state = next_state;
            data_o = buffor;
            ready_o = 1;
        end
        else if (present_state == rx_start)
            ready_o = 0;
        else
            present_state = rx_start;
    
    end
    
endmodule
