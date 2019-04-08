`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2018 05:48:30 PM
// Design Name: 
// Module Name: combination
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


module combination(
    input clk_fpga,
    output ls_cs,
    input ls_miso,
    output ls_sclk,
    output [6:0] sv_seg_disp,
    output [3:0] sv_seg_anode,
    input [3:0] sw,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_hsync,
    output vga_vsync);
    
    wire clk25MHz;
    clk_wiz_0 mmcm (
        // Clock out ports
        .clk_out1(clk25MHz),     // output clk_out1
        // Status and control signals
        .reset(), // input reset
        .locked(),       // output locked
        // Clock in ports
        .clk_in1(clk_fpga)      // input clk_in1
    );
    
    wire [7:0]ls_val;
    light_sensor ls_disp(
        .clk25MHz(clk25MHz),
        .ls_cs(ls_cs),
        .ls_miso(ls_miso),
        .ls_sclk(ls_sclk),
        .ls_val_report(ls_val));
    
    vga_display vga_disp(
        .clk25MHz(clk25MHz),
        .pos_4(ls_val),
        .sw(sw),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync));
        
    seven_seg sv_seg(
        .clk(clk25MHz),
        .sw({8'b0, ls_val}),
        .seg(sv_seg_disp),
        .cnt(sv_seg_anode));
    
    
endmodule
