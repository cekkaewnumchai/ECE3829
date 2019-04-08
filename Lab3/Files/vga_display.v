`timescale 1ns / 1ps
// Creator:	Chaiwat Ekkaewnumchai 
// Module Name: vga_display.v
// Description: set display to specific patterns according to switches and handle buttons

module vga_display(
	//input clk_fpga,
	input clk_25MHz,		// 25MHz clock
	input sw_up,			// button for going up
	input sw_down,			// button for going down	
	input sw_right,			// button for going right	
	input sw_left,          // button for going left
	output [3:0] vga_r,	    // red value of pixel on VGA
	output [3:0] vga_g,	    // green value of pixel on VGA
	output [3:0] vga_b,	    // blue value of pixel on VGA
	output vga_hsync,		// hsync of VGA
	output vga_vsync,		// vsync of VGA
	output [6:0] sv_disp,	// cathode of seven segment
	output [3:0] sv_anode	// anode of seven segment
	);

	wire vga_blank;						// indicate invalid bit
	wire [10:0] vga_hpos, vga_vpos;	// keep track of pixel position
	reg [11:0] vga_rgb;					// store all rgb value in one variable

	/* for separate module to run independently
	wire clk_25MHz;
	clk_wiz_0 mmcm (
		// Clock out ports
		.clk_out2(clk_25MHz),     // output clk_out1
		// Status and control signals
		// Clock in ports
		.clk_in1(clk_fpga)      // input clk_in1
	);*/

    // keep current positions
	reg[4:0] curr_x = 5'd9;
	reg[4:0] curr_y = 5'd9;
	
	// determine if buttons are pushed or unpushed
	wire up_high_act, down_high_act, right_high_act, left_high_act;
	wire up_low_act, down_low_act, right_low_act, left_low_act;
	
	// keep states of buttons explained below
	reg[1:0] up_curr_state, 	up_next_state;
	reg[1:0] down_curr_state, 	down_next_state; 
	reg[1:0] right_curr_state,	right_next_state;
	reg[1:0] left_curr_state,	left_next_state;
	
	// S0		=> signal = 0
	// SCH	=> signal = 1 but have not applied change
	// S1		=> signal = 1 but have applied change
	parameter[1:0] S0 = 0, S1 = 2, SCH = 1;
	
    button_trigger bt_up_high	(clk_25MHz, sw_up,	   1'b1, up_high_act);
	button_trigger bt_down_high	(clk_25MHz, sw_down,   1'b1, down_high_act);
	button_trigger bt_right_high(clk_25MHz, sw_right,  1'b1, right_high_act);
	button_trigger bt_left_high	(clk_25MHz, sw_left,   1'b1, left_high_act);
	
	button_trigger bt_up_low	(clk_25MHz, sw_up,		1'b0, up_low_act);
	button_trigger bt_down_low	(clk_25MHz, sw_down,	1'b0, down_low_act);
	button_trigger bt_right_low(clk_25MHz, sw_right,	1'b0, right_low_act);
	button_trigger bt_left_low	(clk_25MHz, sw_left,    1'b0, left_low_act);
	
	// update states
	always @ (posedge clk_25MHz) begin
		up_curr_state		<= up_next_state;
		down_curr_state	<= down_next_state; 
		right_curr_state	<= right_next_state;
		left_curr_state	<= left_next_state;
	end
	
	// Set state
	always @ (up_curr_state, up_high_act, up_low_act)
		case(up_curr_state)
			S0:  up_next_state = up_high_act ? SCH: S0;
			SCH: up_next_state = S1;
			S1:  up_next_state = up_low_act  ? S0: S1;
			default: up_next_state = S0;
		endcase
	
	always @ (down_curr_state, down_high_act, down_low_act)
		case(down_curr_state)
			S0:  down_next_state = down_high_act ? SCH: S0;
			SCH: down_next_state = S1;
			S1:  down_next_state = down_low_act  ? S0: S1;
			default: down_next_state = S0;
		endcase
	
	always @ (right_curr_state, right_high_act, right_low_act)
		case(right_curr_state)
			S0:  right_next_state = right_high_act ? SCH: S0;
			SCH: right_next_state = S1;
			S1:  right_next_state = right_low_act  ? S0: S1;
			default: right_next_state = S0;
		endcase
		
	always @ (left_curr_state, left_high_act, left_low_act)
		case(left_curr_state)
			S0:  left_next_state = left_high_act ? SCH: S0;
			SCH: left_next_state = S1;
			S1:  left_next_state = left_low_act  ? S0: S1;
			default: left_next_state = S0;
		endcase
			
	// adjust values accordingly
	always @ (posedge clk_25MHz)
		// horizontal
		if(left_curr_state == SCH) 
			curr_y <= curr_y > 0 ? curr_y - 1: curr_y;
		else if(right_curr_state == SCH)
			curr_y <= curr_y < 19 ? curr_y + 1: curr_y;
		// vertical
		else if(up_curr_state == SCH) 
			curr_x <= curr_x > 0 ? curr_x - 1: curr_x;
		else if(down_curr_state == SCH)
			curr_x <= curr_x < 19 ? curr_x + 1: curr_x;
			
	// instantiate the module to get many VGA values
	vga_controller_640_60 vga (
		// input
		.rst(),
		.pixel_clk(clk_25MHz),
		// output
		.HS(vga_hsync),
		.VS(vga_vsync),
		.hcount(vga_hpos),  // second of equivalent array
		.vcount(vga_vpos),  // first of equivalent array
		.blank(vga_blank)  
	);
	
	// to change rgb values to separate values (convenience)
	rgb_to_each display_rgb(vga_rgb, vga_r, vga_g, vga_b);

	// static color to use easily
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
	always @ (vga_blank, vga_vpos, vga_hpos)
		if(vga_blank)	// check if pixel is invalid
			vga_rgb <= COLOR_BLACK;
		else	// assign color 
			// block rectangle start at (curr_x, curr_y) to (curr_x + 24, curr_y + 32)
			if(vga_vpos / 24 == curr_x && vga_hpos / 32 == curr_y )
				vga_rgb <= COLOR_CYAN;
			else
				vga_rgb <= COLOR_WHITE;
				
	// display position
	wire[3:0] xtens_disp = {3'b0, curr_x >= 5'd10};
	wire[3:0] xones_disp = curr_x % 10;
	wire[3:0] ytens_disp = {3'b0, curr_y >= 5'd10};
	wire[3:0] yones_disp = curr_y % 10;
	seven_seg sv(
		.clk(clk_25MHz),
		.values({xtens_disp, xones_disp, ytens_disp, yones_disp}),
		.sv_disp(sv_disp),
		.sv_anode(sv_anode)
	);
	
endmodule