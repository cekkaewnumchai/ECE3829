`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2018 02:17:31 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input sel0,
    input sel1,
    output reg [6:0] seg,
    output reg [3:0] cnt
    );
    
    reg [3:0] bit;
    wire [1:0] sel = {sel1, sel0};
    
    wire test[3:0];
    
    always @ (sel)
    	begin
			case(sel)
				2'b00: cnt = 4'b1110;
				2'b01: cnt = 4'b1101;
				2'b10: cnt = 4'b1011;
				2'b11: cnt = 4'b0111;
			endcase
			case(sel)
				2'b00: bit = a;
				2'b01: bit = b;
				2'b10: bit = c;
				2'b11: bit = d;
			endcase
		end
    	
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
    
    always @ (bit)
    	case(bit)
    		4'b0000: seg = disp_0;
    		4'b0001: seg = disp_1;
    		4'b0010: seg = disp_2;
    		4'b0011: seg = disp_3;
    		4'b0100: seg = disp_4;
    		4'b0101: seg = disp_5;
    		4'b0110: seg = disp_6;
    		4'b0111: seg = disp_7;
    		4'b1000: seg = disp_8;
    		4'b1001: seg = disp_9;
    		4'b1010: seg = disp_A;
    		4'b1011: seg = disp_B;
    		4'b1100: seg = disp_C;
    		4'b1101: seg = disp_D;
    		4'b1110: seg = disp_E;
    		4'b1111: seg = disp_F;
    	endcase
    
    
    
    
    
endmodule
