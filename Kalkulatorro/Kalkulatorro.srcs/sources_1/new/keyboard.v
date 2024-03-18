`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 10:59:21
// Design Name: 
// Module Name: keyboard
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


module keyboard
(
    input clk_i,
    input rst_i,
    input ps2_clk_i,
    input ps2_data_i,
    
    output reg [3 : 0]  data_o,
    output reg ready
);

    parameter   ps2_start   =   4'b0000;
    parameter   ps2_data0   =   4'b0001;
    parameter   ps2_data1   =   4'b0010;
    parameter   ps2_data2   =   4'b0011;
    parameter   ps2_data3   =   4'b0100;
    parameter   ps2_data4   =   4'b0101;
    parameter   ps2_data5   =   4'b0110;
    parameter   ps2_data6   =   4'b0111;
    parameter   ps2_data7   =   4'b1000;
    parameter   ps2_parity  =   4'b1001;
    parameter   ps2_stop    =   4'b1010;
    parameter   ps2_fail    =   4'b1111;

//  TABLICA KONWERSJI ZNAKOW
//  |  KOD KLAWIATURY   | PRZEKONWERTOWANA WARTOSC  |   ZNAK    |
//  |       0x45        |           0x00            |     0     |
//  |       0x16        |           0x01            |     1     | 
//  |       0x1E        |           0x02            |     2     | 
//  |       0x26        |           0x03            |     3     | 
//  |       0x25        |           0x04            |     4     | 
//  |       0x2E        |           0x05            |     5     | 
//  |       0x36        |           0x06            |     6     | 
//  |       0x3D        |           0x07            |     7     | 
//  |       0x3E        |           0x08            |     8     | 
//  |       0x46        |           0x09            |     9     | 
//  |       0x79        |           0x0A            |     +     | 
//  |       0x4E        |           0x0B            |     -     | 
//  |       0x55        |           0x0C            |     =     |
//  |       0x76        |           0x0D            |    ESC    |
//  |     NIEZNANY      |           0x0F            |   BRAK    |

    function [3 : 0] getChar;
        input [7 : 0] data;
        
        begin
            
            case(data)
                8'h45   : getChar = 4'b0000;   // 0
                8'h16   : getChar = 4'b0001;   // 1
                8'h1E   : getChar = 4'b0010;   // 2
                8'h26   : getChar = 4'b0011;   // 3
                8'h25   : getChar = 4'b0100;   // 4
                8'h2E   : getChar = 4'b0101;   // 5
                8'h36   : getChar = 4'b0110;   // 6
                8'h3D   : getChar = 4'b0111;   // 7
                8'h3E   : getChar = 4'b1000;   // 8
                8'h46   : getChar = 4'b1001;   // 9
                8'h79   : getChar = 4'b1010;   // +
                8'h4E   : getChar = 4'b1011;   // -
                8'h55   : getChar = 4'b1100;   // =
                8'h76   : getChar = 4'b1101;   // ESC
                default : getChar = 4'b1111;   // BRAK
            endcase
            
        end
        
    endfunction
    
    reg [3 : 0] currentState    = ps2_start;
    reg [3 : 0] nextState       = ps2_data0;
    
    reg ps2_enable = 1;

    reg [7 : 0] ps2_buffor = 8'h00;
    
    wire ps2_internal_clk;
    
    div #(6_666) ps2_internal_clock  
    (
        clk_i,
        ps2_enable,
        ps2_internal_clk
    );
    
    initial
    begin
        ready = 0;
        ps2_enable = 1;
        ps2_buffor = 8'h00;
        data_o = 3'b000;
    end
    
    always @ (currentState)
    begin
        case (currentState)
            ps2_fail    :   nextState = ps2_start;
            ps2_start   :   nextState = ps2_data0;
            ps2_data0   :   nextState = ps2_data1;
            ps2_data1   :   nextState = ps2_data2;
            ps2_data2   :   nextState = ps2_data3;
            ps2_data3   :   nextState = ps2_data4;
            ps2_data4   :   nextState = ps2_data5;
            ps2_data5   :   nextState = ps2_data6;
            ps2_data6   :   nextState = ps2_data7;
            ps2_data7   :   nextState = ps2_parity;
            ps2_parity  :   nextState = ps2_stop;
            ps2_stop    :   nextState = ps2_start;
            default     :   nextState = ps2_fail;
        endcase
    end
    
    always @ (posedge clk_i, posedge rst_i)
    begin
        if (rst_i)
        begin
            ps2_enable = 1;
        end
        else if (clk_i)
        begin
            if (currentState == ps2_start && ps2_data_i == 0 && ps2_clk_i == 0)
            begin
               ps2_enable = 0;
            end
            else if (currentState == ps2_start && ps2_data_i == 1)
            begin
                ps2_enable = 1;
                
                if (ready)
                    data_o = getChar(ps2_buffor);
            end
        end
    end
    
    always @ (posedge ps2_internal_clk, posedge rst_i)
    begin
    
        if (rst_i)
        begin
            currentState = ps2_start;
            ready = 0;
        end
        else if (ps2_internal_clk)
        begin
            
            if (currentState == ps2_start && ps2_data_i == 0)
            begin
                ready = 0;
            end
            else if (currentState == ps2_data0)
            begin
                ps2_buffor[0] = ps2_data_i;
            end
            else if (currentState == ps2_data1)
            begin
                ps2_buffor[1] = ps2_data_i;
            end
            else if (currentState == ps2_data2)
            begin
                ps2_buffor[2] = ps2_data_i;
            end
            else if (currentState == ps2_data3)
            begin
                ps2_buffor[3] = ps2_data_i;
            end
            else if (currentState == ps2_data4)
            begin
                ps2_buffor[4] = ps2_data_i;
            end
            else if (currentState == ps2_data5)
            begin
                ps2_buffor[5] = ps2_data_i;
            end
            else if (currentState == ps2_data6)
            begin
                ps2_buffor[6] = ps2_data_i;
            end
            else if (currentState == ps2_data7)
            begin
                ps2_buffor[7] = ps2_data_i;
            end
            else if (currentState == ps2_parity)
            begin
                
            end
            else if (currentState == ps2_stop && ps2_data_i == 1)
            begin
                ready = 1;
            end
        
            currentState = nextState;
        end
    
    end


endmodule
