`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2018 11:58:50 AM
// Design Name: 
// Module Name: mcs_top
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


module mcs_top(
	input clk_fpga,
	input reset,
	input sw_up, sw_down, sw_left, sw_right, 
	input mcs_rx,
	output mcs_tx,
	output[15:0] led,
	output[6:0] sv_disp,
	output[3:0] sv_anode
	);
	
	wire clk_100mhz;
	wire clk_en;		// enable every second
	reg[26:0] clk_counter;
	reg[3:0] counter;
	wire up_en, down_en, left_en, right_en;
	
	clk_wiz_0 mmcm
	(
		// Clock out ports
		.clk_out1(clk_100mhz),	// output clk_out1
		// Status and control signals
		.reset(reset), 		// input reset
		// Clock in ports
		.clk_in1(clk_fpga)	// input clk_in1
	);   
	
	// create 1Hz counter
	always @(posedge clk_100mhz, posedge reset)
		if(clk_counter == 27'd99999999 || reset)
			clk_counter <= 27'd0;
		else
			clk_counter <= clk_counter + 27'd1;
	assign clk_en = (clk_counter == 27'd0);
			
	// counter every 1Hz
	always @(posedge clk_100mhz, posedge reset)
		if(clk_en)
			if(counter == 4'b1111 || reset)
				counter <= 4'b0;
			else
				counter <= counter + 4'b1;
   
	
	wire[15:0] val;
	wire up_get, down_get, left_get, right_get;	// indicate that the buttons are used before changing state
	
	
	button_enable bt(
		.clk(clk_100mhz),
		.sw_up(sw_up),
		.sw_down(sw_down),
		.sw_left(sw_left),
		.sw_right(sw_right),
		.up_signal(up_get),
		.down_signal(down_get),
		.left_signal(left_get),
		.right_signal(right_get),
		.up_en(up_en),
		.down_en(down_en),
		.left_en(left_en),
		.right_en(right_en)
	);
		

	microblaze_mcs_0 mcs (
		.Clk(clk_100mhz),		// input wire Clk
		.Reset(reset),			// input wire Reset
		.UART_rxd(mcs_rx),	// input wire UART_rxd
		.UART_txd(mcs_tx),	// output wire UART_txd
		.GPIO1_tri_i({up_en, down_en, left_en, right_en, counter}),	// input wire [7 : 0] GPIO1_tri_i
		.GPIO1_tri_o(led),  // output wire [15 : 0] GPIO1_tri_o
		.GPIO2_tri_o(val[11:0]),  // output wire [11 : 0] GPIO2_tri_o
	  	.GPIO3_tri_o({up_get, down_get, left_get, right_get})  // output wire [3 : 0] GPIO3_tri_o
	);
	
	assign val[15:12] = counter;
	
	seven_seg sv(
		.clk(clk_100mhz),		// clock signal
		.values(val),			// 4 combined values (4 for each)
		.sv_disp(sv_disp),	// cathode of seven segment
		.sv_anode(sv_anode)	// anode of seven segment
	);
endmodule
