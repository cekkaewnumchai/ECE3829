`timescale 1ns / 1ps
// Creator:
// Module Name:
// Description:

module dac_waveform(
	//input clk_fpga,			// 100MHz clock signal
	input clk_10MHz,
	input reset,
	input sw_voltage,			// indicate selection of 3.3V
	input sw_sawtooth,		// indicate selection of saw-tooth
	input sw_triangle,		// indicate selection of triangle
	output dw_sclk,			// SCLK of DAC
	output reg dw_sync,		// SYNC of DAC
	output dw_mosi,			// SDI of DAC
	output[6:0] sv_disp,
	output[3:0] sv_anode
	);
	
	/* for separate module to run independently
	wire clk_10MHz;	// note that one cycle takes 100 ns
					// it is obviously greater than the all set-up time
	// MMCM 100MHz -> 10MHz
	clk_wiz_0 mmcm (
		// Clock out ports
		.clk_out1(clk_10MHz),	// output clk_out1
		// Clock in ports
		.clk_in1(clk_fpga)	// input clk_in1
	);*/

	// set SCLK to 10MHz clock
	assign dw_sclk = clk_10MHz;
	
	// divide it to trigger at 100KHz rate (10MHz -> 100KHz = 100 times)
	reg[7:0] cnt = 0;
	always @ (posedge clk_10MHz)
		if(cnt == 99)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	
	wire clk_en = (cnt == 0);
	
	reg[4:0] sw_val = 0;	// saw-tooth wave value to generate 
	reg[3:0] tri_val = 0;	// triangle wave value to generate
	reg tri_plus = 0;       // indicate that triangle is going up or down
	reg[15:0] dw_dat = 0;   // shift register
	// 0 -> stand-by state
	// i (> 0) -> the ith bit from MSB (considered before all shifts)
	reg[4:0] shift_state = 0; 
	
	// initialize value to master-out-slave-in
	always @ (negedge clk_10MHz, posedge reset) 
		if(reset) begin
			dw_sync <= 1;
			sw_val <= 0;
			tri_val <= 0;
			tri_plus <= 1;
			dw_dat <= 0;
			shift_state <= 0;
		end
		else begin
			// initialize the value
			if(clk_en) begin
				// the value of saw-tooth
				// note: 100kHz -> 3.125kHz = 32 sections 
				if(sw_val == 31)
					sw_val <= 0;
				else
					sw_val <= sw_val + 1;
				// the value of triangle
				if(tri_val == 15) begin
					tri_plus <= 0;
					tri_val <= tri_val - 1;
				end
				else if(tri_val == 0) begin
					tri_plus <= 1;
					tri_val <= tri_val + 1;
				end
				else if(tri_plus)
					tri_val <= tri_val + 1;
				else
					tri_val <= tri_val - 1;
				
				if(sw_sawtooth)
					dw_dat <= {8'b0, sw_val, 3'b0};	   // set to saw-tooth
				else if(sw_triangle)
					dw_dat <= {8'b0, tri_val, 4'b0};
				else if(sw_voltage)
					dw_dat <= {8'b0, 8'hff};			// set to constant
				else
					dw_dat <= {8'b0, 8'b0};            // set zero
					
				// set state to 1st and trigger SYNC
				shift_state <= 1;
				dw_sync <= 0;
			end
		      
		    // if shift register rotates all bits
			if(shift_state == 5'd16)
				dw_sync <= 1;
			
			// start process of shift register
			if(!dw_sync) begin
				dw_dat <= {dw_dat[14:0], dw_dat[15]};
				shift_state <= shift_state + 1;
			end
		end
		
	// set output to MSB of shift register
	assign dw_mosi = dw_dat[15];
			
	// display value on seven segment
	reg[15:0] val_disp;
	always @ (posedge clk_10MHz) 
		if(sw_sawtooth)
			val_disp <= {8'b0, sw_val, 3'b0};
		else if(sw_triangle)
			val_disp <= {8'b0, tri_val, 4'b0};
		else if(sw_voltage)
			val_disp <= {8'b0, 8'hff};			
		else
			val_disp <= {8'b0, 8'b0}; 
			
	seven_seg sv(
		.clk(clk_10MHz),
		.values(val_disp),
		.sv_disp(sv_disp),
		.sv_anode(sv_anode)
	);

endmodule