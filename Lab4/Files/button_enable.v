`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2018 02:18:16 PM
// Design Name: 
// Module Name: button_enable
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


module button_enable(
	input clk,
	input sw_up, sw_down, sw_left, sw_right,
	input up_signal, down_signal, left_signal, right_signal,
	output up_en, down_en, left_en, right_en
	);
    
	wire up_high_act, down_high_act, right_high_act, left_high_act;
	wire up_low_act, down_low_act, right_low_act, left_low_act;
	
	reg[1:0] up_curr_state, 	up_next_state;
	reg[1:0] down_curr_state, 	down_next_state; 
	reg[1:0] right_curr_state,	right_next_state;
	reg[1:0] left_curr_state,	left_next_state;
	
	// S0		=> signal = 0
	// SCH	=> signal = 1 but have not applied change
	// S1		=> signal = 1 but have applied change
	parameter[1:0] S0 = 0, S1 = 2, SCH = 1;

	button_trigger bt_up_high		(clk, sw_up,	 1'b1, up_high_act);
	button_trigger bt_down_high	(clk, sw_down,	 1'b1, down_high_act);
	button_trigger bt_right_high	(clk, sw_right, 1'b1, right_high_act);
	button_trigger bt_left_high	(clk, sw_left,	 1'b1, left_high_act);

	button_trigger bt_up_low	(clk, sw_up,		1'b0, up_low_act);
	button_trigger bt_down_low	(clk, sw_down,		1'b0, down_low_act);
	button_trigger bt_right_low(clk, sw_right,	1'b0, right_low_act);
	button_trigger bt_left_low	(clk, sw_left,		1'b0, left_low_act);

	// to slow down 100MHz clock
	reg[1:0] counter;
	always @ (posedge clk)
		if(counter == 2'b11)
			counter <= 0;
		else
			counter <= counter + 1;
	wire clk_en = (counter == 2'b0);

	always @ (posedge clk) 
		if(clk_en) begin
			up_curr_state		<= up_next_state;
			down_curr_state	<= down_next_state; 
			right_curr_state	<= right_next_state;
			left_curr_state	<= left_next_state;
		end

	// Set state
	always @ (up_curr_state, up_high_act, up_low_act, up_signal)
		case(up_curr_state)
			S0:  up_next_state = up_high_act ? SCH: S0;
			SCH: up_next_state = up_signal	? S1: SCH;
			S1:  up_next_state = up_low_act  ? S0: S1;
			default: up_next_state = S0;
		endcase

	always @ (down_curr_state, down_high_act, down_low_act, down_signal)
		case(down_curr_state)
			S0:  down_next_state = down_high_act ? SCH: S0;
			SCH: down_next_state = down_signal   ? S1: SCH;
			S1:  down_next_state = down_low_act  ? S0: S1;
			default: down_next_state = S0;
		endcase

	always @ (right_curr_state, right_high_act, right_low_act, right_signal)
		case(right_curr_state)
			S0:  right_next_state = right_high_act ? SCH: S0;
			SCH: right_next_state = right_signal  	? S1: SCH;
			S1:  right_next_state = right_low_act  ? S0: S1;
			default: right_next_state = S0;
		endcase

	always @ (left_curr_state, left_high_act, left_low_act, left_signal)
		case(left_curr_state)
			S0:  left_next_state = left_high_act ? SCH: S0;
			SCH: left_next_state = left_signal   ? S1: SCH;
			S1:  left_next_state = left_low_act  ? S0: S1;
			default: left_next_state = S0;
		endcase
	
	assign up_en		= (up_curr_state == SCH);
	assign down_en 	= (down_curr_state == SCH);
	assign left_en 	= (left_curr_state == SCH);
	assign right_en	= (right_curr_state == SCH);
	
	
endmodule
