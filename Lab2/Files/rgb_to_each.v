`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2018 03:35:08 PM
// Design Name: 
// Module Name: rgb_to_each
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


module rgb_to_each(
    input [11:0] rgb,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
    );
    
    assign r = rgb[11:8];
    assign g = rgb[7:4];
    assign b = rgb[3:0];
    
endmodule
