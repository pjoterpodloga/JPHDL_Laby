`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2024 11:55:08
// Design Name: 
// Module Name: calculator
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


module calculator
(
    input clk_i,
    input rst_i,
    
    input [3 : 0] data_i,
    input data_ready,
    
    output [31 : 0] data_o
);

    parameter d0_n1  = 4'b0001;
    parameter d1_n1  = 4'b0011;
    parameter d2_n1  = 4'b0101;
    parameter d3_n1  = 4'b0111;
    
    parameter opt    = 4'b1001;
    
    parameter d0_n2  = 4'b0000;
    parameter d1_n2  = 4'b0010;
    parameter d2_n2  = 4'b0100;
    parameter d3_n2  = 4'b0110;
    
    reg [3 : 0] currentState = d0_n1;
    reg [3 : 0] nextState    = d1_n1;

    reg [3 : 0] segChar [7 : 0];
    
    assign data_o[3  :  0]  = segChar[0];
    assign data_o[7  :  4]  = segChar[1];
    assign data_o[11 :  8]  = segChar[2];
    assign data_o[15 : 12]  = segChar[3];
    assign data_o[19 : 16]  = segChar[4];
    assign data_o[23 : 20]  = segChar[5];
    assign data_o[27 : 24]  = segChar[6];
    assign data_o[31 : 28]  = segChar[7];
    
    reg  [3 : 0] first_number    [3 : 0];
    reg  [3 : 0] second_number   [3 : 0];
    
    wire [3 : 0] result_add [3 : 0];
    wire [3 : 0] result_sub [3 : 0];
    
    reg [1 : 0] operation = 2'b01;
    
    reg [7 : 0] leading_zero = 0;
    
    wire [3 : 0] carry;
    wire [3 : 0] borrow;
    
    adder_bcd adder_1 (first_number[0], second_number[0], 1'b0,     result_add[0], carry[0]);
    adder_bcd adder_2 (first_number[1], second_number[1], carry[0], result_add[1], carry[1]);
    adder_bcd adder_3 (first_number[2], second_number[2], carry[1], result_add[2], carry[2]);
    adder_bcd adder_4 (first_number[3], second_number[3], carry[2], result_add[3], carry[3]);
    
    subtractor_bcd sub_1 (first_number[0], second_number[0], 1'b0,      result_sub[0], borrow[0]);
    subtractor_bcd sub_2 (first_number[1], second_number[1], borrow[0], result_sub[1], borrow[1]);
    subtractor_bcd sub_3 (first_number[2], second_number[2], borrow[1], result_sub[2], borrow[2]);
    subtractor_bcd sub_4 (first_number[3], second_number[3], borrow[2], result_sub[3], borrow[3]);
    
    initial
    begin
        first_number[0] = 4'b0000;
        first_number[1] = 4'b0000;
        first_number[2] = 4'b0000;
        first_number[3] = 4'b0000;
        
        second_number[0] = 4'b0000;
        second_number[1] = 4'b0000;
        second_number[2] = 4'b0000;
        second_number[3] = 4'b0000;
        
        operation = 2'b01;
    end
    
    always @ (posedge clk_i)
    begin
    
        if (currentState[0])
        begin
            segChar[0] <= first_number[0];
            segChar[1] <= first_number[1];
            segChar[2] <= first_number[2];
            segChar[3] <= first_number[3];
        end
        else
        begin
            segChar[0] <= second_number[0];
            segChar[1] <= second_number[1];
            segChar[2] <= second_number[2];
            segChar[3] <= second_number[3];
        end
        
        segChar[4] <= 4'b1111;
        segChar[5] <= 4'b1111;
        segChar[6] <= 4'b1111;
        segChar[7] <= 4'b1111;
        
    end
    
    always @ (posedge data_ready, posedge rst_i)
    begin
    
        if (rst_i)
        begin   
            first_number[0] = 4'b0000;
            first_number[1] = 4'b0000;
            first_number[2] = 4'b0000;
            first_number[3] = 4'b0000;
            
            second_number[0] = 4'b0000;
            second_number[1] = 4'b0000;
            second_number[2] = 4'b0000;
            second_number[3] = 4'b0000;
        end
        else if (data_ready)
        begin
            
            if (data_i == 4'b1010 || data_i == 4'b1011 || 
                data_i == 4'b1100 || data_i == 4'b1101)
            begin
                
                if (data_i == 4'b1010)
                begin
                    operation = 2'b01;
                    currentState = d0_n2;
                end
                else if (data_i == 4'b1011)
                begin
                    operation = 2'b11;
                    currentState = d0_n2;
                end
                else if (data_i == 4'b1101)
                begin
                    first_number[0] <= 4'b0000;
                    first_number[1] <= 4'b0000;
                    first_number[2] <= 4'b0000;
                    first_number[3] <= 4'b0000;
                    
                    second_number[0] <= 4'b0000;
                    second_number[1] <= 4'b0000;
                    second_number[2] <= 4'b0000;
                    second_number[3] <= 4'b0000;
                    
                    currentState = d0_n1;
                end
                
                else if (data_i == 4'b1100)
                begin
                    // DO THE MATH!
                    // result => first_number
                    
                    if (!operation[1])
                    begin
                        first_number[0] = result_add[0];
                        first_number[1] = result_add[1];
                        first_number[2] = result_add[2];
                        first_number[3] = result_add[3];
                    end
                    else
                    begin
                        first_number[0] = result_sub[0];
                        first_number[1] = result_sub[1];
                        first_number[2] = result_sub[2];
                        first_number[3] = result_sub[3];
                    end
                    
                    second_number[0] = 4'b0000;
                    second_number[1] = 4'b0000;
                    second_number[2] = 4'b0000;
                    second_number[3] = 4'b0000;
                    
                    currentState = opt;
                end
                
            end
            else if (data_i != 4'b1111)
            begin
                
                if (currentState == d0_n1)
                begin
                    first_number[0] <= data_i;
                    currentState = d1_n1;
                end
                else if (currentState == d1_n1)
                begin
                    first_number[1] <= first_number[0];
                    first_number[0] <= data_i;
                    currentState = d2_n1;
                end                
                else if (currentState == d2_n1)
                begin
                    first_number[2] <= first_number[1];
                    first_number[1] <= first_number[0];
                    first_number[0] <= data_i;
                    currentState = d3_n1;
                end
                else if (currentState == d3_n1)
                begin
                    first_number[3] <= first_number[2];
                    first_number[2] <= first_number[1];
                    first_number[1] <= first_number[0];
                    first_number[0] <= data_i;
                    currentState = opt;
                end
                
                if (currentState == d0_n2)
                begin
                    second_number[0] <= data_i;
                    currentState = d1_n2;
                end
                else if (currentState == d1_n2)
                begin
                    second_number[1] <= second_number[0];
                    second_number[0] <= data_i;
                    currentState = d2_n2;
                end                
                else if (currentState == d2_n2)
                begin
                    second_number[2] <= second_number[1];
                    second_number[1] <= second_number[0];
                    second_number[0] <= data_i;
                    currentState = d3_n2;
                end
                else if (currentState == d3_n2)
                begin
                    second_number[3] <= second_number[2];
                    second_number[2] <= second_number[1];
                    second_number[1] <= second_number[0];
                    second_number[0] <= data_i;
                    currentState = opt;
                end
                
            end
            
        end
        
    end

endmodule
