`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 18:19:10
// Design Name: 
// Module Name: seg_con_tb
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


module seg_con_tb ( );

reg [31 : 0] seg_data_i;
reg clk_i;

wire [7 : 0] an_o;
wire [7 : 0] seg_o;

parameter [31 : 0] data1 = 32'hABCD1234;
parameter [31 : 0] data2 = 32'h4321DCBA;

seg_con segmentController (seg_data_i, clk_i, an_o, seg_o);

initial
begin
    seg_data_i[31 : 0] = 0;
    clk_i = 0;
end

always
begin
    #5 clk_i = ~clk_i;
end

initial
begin
    #100_0000 seg_data_i = data1;
    #1_600_0000
    #1_600_0000 
    #100_0000 seg_data_i = data2;
    #1800_0000 $finish;
end

endmodule
