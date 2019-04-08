`timescale 1ns / 1ps
// Creator: Chaiwat Ekkaewnumchai
// Module Name: rgb_to_each.v
// Description: Change rgb value to separate r,g, and b values

module rgb_to_each(
    input [11:0] rgb,	// rgb values (red-green-blue)
    output [3:0] r,		// r value (red)
    output [3:0] g,		// g value (green)
    output [3:0] b		// b value (blue)
    );
    
    assign r = rgb[11:8];
    assign g = rgb[7:4];
    assign b = rgb[3:0];
    
endmodule
