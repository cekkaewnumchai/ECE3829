`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2018 03:03:41 PM
// Design Name: 
// Module Name: vga_display
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


module vga_display(
        input clk25MHz,
        input [7:0] pos_4,
        input [3:0] sw,
        output [3:0] vga_r,
        output [3:0] vga_g,
        output [3:0] vga_b,
        output vga_hsync,
        output vga_vsync
    );
    
    wire reset, locked, vga_blank;
    wire [10:0] vga_hpos, vga_vpos;
    reg [11:0] vga_rgb;
    
    /* to use separately
    wire clk25MHz;
    clk_wiz_0 mmcm (
        // Clock out ports
        .clk_out1(clk25MHz),     // output clk_out1
        // Status and control signals
        .reset(reset), // input reset
        .locked(locked),       // output locked
        // Clock in ports
        .clk_in1(clk_fpga)      // input clk_in1
    );*/

    vga_controller_640_60 vga (
        // input
        .rst(reset),
        .pixel_clk(clk25MHz),
        // output
        .HS(vga_hsync),
        .VS(vga_vsync),
        .hcount(vga_hpos),  // second of equivalent array
        .vcount(vga_vpos),  // first of equivalent array
        .blank(vga_blank)  
    );
    
    reg [8:0] pos;
    always @ (clk25MHz)
        begin
            pos = pos_4 * 7 / 4;
        end
        
    
    rgb_to_each display_rgb(vga_rgb, vga_r, vga_g, vga_b);
    
    parameter [11:0] COLOR_RED      = 12'b1111_0000_0000;
    parameter [11:0] COLOR_GREEN    = 12'b0000_1111_0000;
    parameter [11:0] COLOR_BLUE     = 12'b0000_0000_1111;
    parameter [11:0] COLOR_YELLOW   = 12'b1111_1111_0000;
    parameter [11:0] COLOR_MAGENTA  = 12'b1111_0000_1111;
    parameter [11:0] COLOR_CYAN     = 12'b0000_1111_1111;
    parameter [11:0] COLOR_WHITE    = 12'b1111_1111_1111;
    parameter [11:0] COLOR_BLACK    = 12'b0000_0000_0000;
    
    // 640 * 480
    // encounter blank condition which makes green black
    always @ (vga_hpos, vga_vpos, sw, vga_blank)
        if(vga_blank)
            vga_rgb <= COLOR_BLACK;
        else
            begin
                if(sw[0])
                    vga_rgb <= COLOR_GREEN;
                else if(sw[1])  // 480 / 8 = 60 
                    if(vga_vpos < 60)
                        vga_rgb <= COLOR_WHITE;
                    else if(vga_vpos < 120)
                        vga_rgb <= COLOR_RED;
                    else if(vga_vpos < 180)
                        vga_rgb <= COLOR_YELLOW;
                    else if(vga_vpos < 240)
                        vga_rgb <= COLOR_GREEN;
                    else if(vga_vpos < 300)
                        vga_rgb <= COLOR_CYAN;
                    else if(vga_vpos < 360)
                        vga_rgb <= COLOR_BLUE;
                    else if(vga_vpos < 420)
                        vga_rgb <= COLOR_MAGENTA;
                    else
                        vga_rgb <= COLOR_BLACK;
                else if(sw[2])
                    if(vga_hpos >= 312 && vga_hpos < 336 && vga_vpos < 32)
                        vga_rgb <= COLOR_YELLOW;
                    else
                        vga_rgb <= COLOR_BLACK;
                else if(sw[3])
                    if(vga_hpos >= 312 && vga_hpos < 336 && vga_vpos >= pos && vga_vpos < pos + 32)
                        vga_rgb <= COLOR_YELLOW;
                    else
                        vga_rgb <= COLOR_BLACK;
                else
                    vga_rgb <= COLOR_WHITE;
            end
endmodule
