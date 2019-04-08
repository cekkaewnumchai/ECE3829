`timescale 1ns / 1ps
// Creator: Chaiwat Ekkaewnumchai
// Module Name: seven_seg.v
// Description: show specific four combined values (4 bits) to four panels

module seven_seg(
	input clk,						// clock signal
	input [15:0] values,			// 4 combined values (4 for each)
	output reg [6:0] sv_disp,	// cathode of seven segment
	output reg [3:0] sv_anode	// anode of seven segment
	);
	
	reg [3:0] current_value;	// value to be shown (one at a time)
	
	// divide values to separated values
	wire [3:0] a, b, c, d;
	assign a = values[3:0];
	assign b = values[7:4];
	assign c = values[11:8];
	assign d = values[15:12];


	reg [1:0] sel = 2'b00;	// indicate which panel is selected
	reg [10:0] x = 0;	// counter and clock divider

	// clock divider
	always @ (posedge clk) begin
		if(x == 2000) begin
			x <= 0;
			// set selection panel
			if(sel == 2'b11)
				sel <= 2'b00;
			else
				sel <= sel + 1;
		end
		else
			x <= x + 1;
	end

	// set value to be shown according to 'sel'
	always @ (sel) begin      
		case(sel)
			2'b00: current_value = a;
			2'b01: current_value = b;
			2'b10: current_value = c;
			2'b11: current_value = d;
		endcase
			  
		case(sel)
			2'b00: sv_anode = 4'b1110;
			2'b01: sv_anode = 4'b1101;
			2'b10: sv_anode = 4'b1011;
			2'b11: sv_anode = 4'b0111;
		endcase
	end

	// constant from '0' to 'F'
	parameter disp_0 = 7'b1000000;
	parameter disp_1 = 7'b1111001;
	parameter disp_2 = 7'b0100100;
	parameter disp_3 = 7'b0110000;
	parameter disp_4 = 7'b0011001;
	parameter disp_5 = 7'b0010010;
	parameter disp_6 = 7'b0000010;
	parameter disp_7 = 7'b1111000;
	parameter disp_8 = 7'b0000000;
	parameter disp_9 = 7'b0010000;
	parameter disp_A = 7'b0001000;
	parameter disp_B = 7'b0000011;
	parameter disp_C = 7'b1000110;
	parameter disp_D = 7'b0100001;
	parameter disp_E = 7'b0000110;
	parameter disp_F = 7'b0001110;

	// set value to show according to the value set early
	always @ (current_value)
		case(current_value)
			4'b0000: sv_disp = disp_0;
			4'b0001: sv_disp = disp_1;
			4'b0010: sv_disp = disp_2;
			4'b0011: sv_disp = disp_3;
			4'b0100: sv_disp = disp_4;
			4'b0101: sv_disp = disp_5;
			4'b0110: sv_disp = disp_6;
			4'b0111: sv_disp = disp_7;
			4'b1000: sv_disp = disp_8;
			4'b1001: sv_disp = disp_9;
			4'b1010: sv_disp = disp_A;
			4'b1011: sv_disp = disp_B;
			4'b1100: sv_disp = disp_C;
			4'b1101: sv_disp = disp_D;
			4'b1110: sv_disp = disp_E;
			4'b1111: sv_disp = disp_F;
		endcase

endmodule
