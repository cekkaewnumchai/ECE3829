`timescale 1ns / 1ps
// Creator:
// Module Name:
// Description:

module combination(
	input clk_fpga,
	input sw_voltage,			// indicate selection of 3.3V
	input sw_sawtooth,		// indicate selection of saw-tooth
	input sw_triangle,		// indicate selection of triangle
	input sw_up,			
	input sw_down,				
	input sw_right,				
	input sw_left,
	output dw_sclk,			// SCLK of DAC
	output dw_sync,		// SYNC of DAC
	output dw_mosi,			// SDI of DAC
	output[3:0] vga_r,	// red value of pixel on VGA
	output[3:0] vga_g,	// green value of pixel on VGA
	output[3:0] vga_b,	// blue value of pixel on VGA
	output vga_hsync,		// hsync of VGA
	output vga_vsync,		// vsync of VGA
	output[6:0] sv_disp,
	output[3:0] sv_anode
	);
	
	wire clk_10MHz, clk_25MHz;
	clk_wiz_0 mmcm (
		// Clock out ports
		.clk_out1(clk_10MHz),	// output clk_out1
		.clk_out2(clk_25MHz),
		// Clock in ports
		.clk_in1(clk_fpga)	// input clk_in1
	);
	
	dac_waveform dc(
		.clk_10MHz(clk_10MHz),
		.sw_voltage(sw_voltage),			
		.sw_sawtooth(sw_sawtooth),		
		.sw_triangle(sw_triangle),		
		.dw_sclk(dw_sclk),			
		.dw_sync(dw_sync),		
		.dw_mosi(dw_mosi)
	);
	
	vga_display vga(
		clk_25MHz,	
		sw_up,			
		sw_down,				
		sw_right,				
		sw_left,
		vga_r,	
		vga_g,	
		vga_b,	
		vga_hsync,		
		vga_vsync,		
		sv_disp,	
		sv_anode	
	);

endmodule