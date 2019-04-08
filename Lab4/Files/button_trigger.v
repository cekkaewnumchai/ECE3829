`timescale 1ns / 1ps
// Creator:	Chaiwat Ekkaewnumchai 
// Module Name: 
// Description: 

module button_trigger(
	input clk,
	input in,
	input zero_to_one,	// 1: 0 -> 1 and 0: 1 -> 0
	output out_active		// 1 if the value if 1 through 3 signal clocks
	);
	
	parameter[1:0] S0 = 0;
	parameter[1:0] S1 = 1;
	parameter[1:0] S2 = 2;
	parameter[1:0] S3 = 3;
	reg[1:0] current_state, next_state;
	
	reg[16:0] cnt;
	wire clk_en;
	
	// assign next state and count
	always @ (posedge clk) begin
		current_state <= next_state;
		if(cnt == 17'd119999)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end
		
	// clock enable to slow down the clock
	assign clk_en = (cnt == 0);
	
	wire inactive = zero_to_one ^ in;
	
	always @ (current_state, in, inactive)
		if(inactive)
			next_state = S0;
		else if(!inactive && clk_en)
			case(current_state)
				S0: next_state = S1;
				S1: next_state = S2;
				S2: next_state = S3;
				S3: next_state = S3;
			endcase
		else
			next_state = current_state;
			
	assign out_active = (current_state == S3);
	
endmodule
