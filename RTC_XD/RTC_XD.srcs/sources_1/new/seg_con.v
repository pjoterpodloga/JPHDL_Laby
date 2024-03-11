`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 17:14:03
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


module seg_con
    (
    input [31 : 0] seg_data_i,
    input clk_i,
    output reg [7 : 0] an_o,
    output reg [7 : 0] seg_o
    );
    
    function [7 : 0] segChar;
        input [3 : 0] data;
        begin
            case (data)
                4'b0000 : segChar = 8'b0000_0011;   // 0
                4'b0001 : segChar = 8'b1001_1111;   // 1
                4'b0010 : segChar = 8'b0010_0101;   // 2
                4'b0011 : segChar = 8'b0000_1101;   // 3
                4'b0100 : segChar = 8'b1001_1001;   // 4
                4'b0101 : segChar = 8'b0100_1001;   // 5
                4'b0110 : segChar = 8'b0100_0001;   // 6
                4'b0111 : segChar = 8'b0001_1111;   // 7
                4'b1000 : segChar = 8'b0000_0001;   // 8
                4'b1001 : segChar = 8'b0000_1001;   // 9
                4'b1010 : segChar = 8'b0001_0001;   // A
                4'b1011 : segChar = 8'b1100_0001;   // B
                4'b1100 : segChar = 8'b0110_0011;   // C
                4'b1101 : segChar = 8'b1000_0101;   // D
                4'b1110 : segChar = 8'b0110_0001;   // E
                4'b1111 : segChar = 8'b0111_0001;   // F
                default : segChar = 8'b1111_1111;   // *blank*
            endcase
        end
    endfunction

    parameter an0_state     = 4'b0000;
    parameter an1_state     = 4'b0001;
    parameter an2_state     = 4'b0010;
    parameter an3_state     = 4'b0011;
    parameter an4_state     = 4'b0100;
    parameter an5_state     = 4'b0101;
    parameter an6_state     = 4'b0110;
    parameter an7_state     = 4'b0111;
    parameter anoff_state   = 4'b1111;

    reg [3 : 0] currentState = anoff_state;
    reg [3 : 0] nextState;
    
    wire [3 : 0] segData[7 : 0];

    wire an_clk;

    div #(10_000) divider (clk_i, 0, an_clk);
    
    initial
    begin
        an_o[7 : 0] = 8'hFF;
        seg_o [7 : 0] = 8'hFF;
    end
    
    assign segData[0] = seg_data_i[3  : 0];     // Pierwszy segment
    assign segData[1] = seg_data_i[7  : 4];     // Drugi segment
    assign segData[2] = seg_data_i[11 : 8];     // Trzeci segment
    assign segData[3] = seg_data_i[15 : 12];    // Czwarty segment
    assign segData[4] = seg_data_i[19 : 16];    // Piaty segment
    assign segData[5] = seg_data_i[23 : 20];    // Szosty segment
    assign segData[6] = seg_data_i[27 : 24];    // Siodmy segment
    assign segData[7] = seg_data_i[31 : 28];    // Osmy segment
    
    always @ (posedge clk_i)
    begin
        case (currentState)
            anoff_state : begin nextState = an0_state; an_o = 8'b1111_1111; seg_o = 8'hFF; end
            an0_state   : begin nextState = an1_state; an_o = 8'b1111_1110; seg_o = segChar(segData[0]); end
            an1_state   : begin nextState = an2_state; an_o = 8'b1111_1101; seg_o = segChar(segData[1]); end
            an2_state   : begin nextState = an3_state; an_o = 8'b1111_1011; seg_o = segChar(segData[2]); end
            an3_state   : begin nextState = an4_state; an_o = 8'b1111_0111; seg_o = segChar(segData[3]); end
            an4_state   : begin nextState = an5_state; an_o = 8'b1110_1111; seg_o = 8'hFF; end
            an5_state   : begin nextState = an6_state; an_o = 8'b1101_1111; seg_o = 8'hFF; end
            an6_state   : begin nextState = an7_state; an_o = 8'b1011_1111; seg_o = 8'hFF; end
            an7_state   : begin nextState = an0_state; an_o = 8'b0111_1111; seg_o = 8'hFF; end
            default     : nextState = anoff_state;
        endcase
    end
    
    always @ (posedge an_clk)
    begin
        if (an_clk)
            currentState = nextState;
        else
            currentState = anoff_state;
    end

    
endmodule