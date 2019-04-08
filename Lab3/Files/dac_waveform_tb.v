`timescale 1ns / 1ps
// Creator:
// Module Name:
// Description:

module dac_waveform_tb;
	
	// input
	reg clk_10MHz;
	reg reset;
	reg sw_voltage;			
	reg sw_sawtooth;	
	reg sw_triangle;
	// output
	wire dw_sclk;	
	wire dw_sync;		
	wire dw_mosi;			
	wire[6:0] sv_disp;
	wire[3:0] sv_anode;
	
	dac_waveform UUT(
		.clk_10MHz(clk_10MHz),
		.reset(reset),
		.sw_voltage(sw_voltage),
		.sw_sawtooth(sw_sawtooth),
		.sw_triangle(sw_triangle),
		.dw_sclk(dw_sclk),
		.dw_sync(dw_sync),
		.dw_mosi(dw_mosi),
		.sv_disp(sv_disp),
		.sv_anode(sv_anode)
	);
	
	always begin
		clk_10MHz = 0;
		#50;
		clk_10MHz = 1;
		#50;
	end
	
	initial begin
        sw_voltage = 0;
        sw_sawtooth = 0;
        sw_triangle = 0;
        
		#200;
		reset = 1;
		#200;
		reset = 0;
		
		#600;
		$display("Start 0 voltage");
		#40000;
		$display("Start constant voltage");
		sw_voltage = 1;
		#40000;
        $display("Start sawtooth voltage");
        sw_voltage = 0;
        sw_sawtooth = 1;
        #350000;
        $display("Start triangle voltage");
        sw_sawtooth = 0;
        sw_triangle = 1;
        #350000;
		$finish;
	end
	
endmodule
	