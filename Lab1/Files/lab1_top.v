`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2018 03:58:35 PM
// Design Name: 
// Module Name: lab1_top
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


module lab1_top(
    input [15:0] sw,
    input sel0,
    input sel1,
    input sel2,
    input sel3,
    output [6:0] seg,
    output [3:0] cnt
    );
    
    reg [3:0] a, b, c, d;
    reg [8:0] ans;
    seven_seg disp(.a(a), .b(b), .c(c), .d(d), .sel0(sel0), .sel1(sel1), .seg(seg), .cnt(cnt));
    
    wire [1:0] sel = {sel3, sel2};
    
    always @ (sel)
    	begin
    		if(sel == 2'b00) 
				begin
					a = sw[3:0];
					b = sw[7:4];
					c = sw[11:8];
					d = sw[15:12];
    			end
    		else if(sel == 2'b01)
    			begin
					d = 4'b0011;
					c = 4'b1000;
					b = 4'b0010;
					a = 4'b1001;
    			end
    		else if(sel == 2'b10)
    			begin
					d = 4'b0000;
					c = 4'b0110;
					b = 4'b1001;
					a = 4'b0011;
    			end
			else if(sel == 2'b11)
				begin
					ans = sw[7:0] + sw[15:8];
					a = ans % 10;
					b = ans / 10 % 10;
					c = ans / 100 % 10;
					d = 0;
				end
    	end
    /*
    always @ (sw)
		if(sel == 2'b00) 
			begin
				a = sw[3:0];
				b = sw[7:4];
				c = sw[11:8];
				d = sw[15:12];
			end
    	else if(sel == 2'b11)
    		begin
    			ans = sw[7:0] + sw[15:8];
    			d = ans % 10;
    			c = ans / 10 % 10;
    			b = ans / 100 % 10;
    			a = 0;
    		end
    		*/
    
endmodule
