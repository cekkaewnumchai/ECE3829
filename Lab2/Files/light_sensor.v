`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2018 02:04:07 PM
// Design Name: 
// Module Name: light_sensor
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


module light_sensor(
    input clk25MHz,
    output reg ls_cs,
    input ls_miso,
    output reg ls_sclk,
    //output [6:0]sv_seg_disp,
    //output [3:0]sv_seg_anode,
    output reg [7:0]ls_val_report
    );
    
    wire reset, locked;
    
    
    /* To be used separately
    wire clk25MHz;
    clk_wiz_0 mmcm (
            // Clock out ports
            .clk_out1(clk25MHz),     // output clk_out1
            // Status and control signals
            .reset(reset), // input reset
            .locked(locked),       // output locked
            // Clock in ports
            .clk_in1(clk_fpga)      // input clk_in1
        );
    */
    reg[7:0] ls_val;
    //seven_seg sv_seg(clk25MHz, {8'b0, ls_val_report}, sv_seg_disp, sv_seg_anode);
    
    // Create 1MHZ sclk
    reg[5:0] cnt = 0;
    always @ (posedge clk25MHz)
        if(cnt == 11)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    wire en = (cnt == 0);
    always @ (posedge clk25MHz)
        if(en)
            ls_sclk <= ~ls_sclk;
        
    // read value of light sensor
    reg [3:0]read_bit = 0; 
    reg read_ready;
    always @ (posedge clk25MHz)
        if(ls_sclk)
            if(!ls_cs)
                begin
                if(read_ready)
                    begin
                        if(read_bit > 3 && read_bit < 12) // somehow
                            ls_val <= {ls_val[6:0], ls_miso};
                        read_bit <= read_bit + 1;
                        read_ready <= 0;
                    end
                end
            else
                read_bit <= 0;
        else
            read_ready <= 1;
          
    
    // report value to seven segment display
    reg [22:0]cnt_copy = 0;
    always @ (posedge clk25MHz)
        begin
            if(cnt_copy == 4999999)
                cnt_copy <= 0;
            else 
                cnt_copy <= cnt_copy + 1;
                
            if(cnt_copy % 400 == 0)
                ls_cs <= ~ls_cs;
        end
    wire copy_val = (cnt_copy == 0);
    always @ (posedge clk25MHz)
        if(copy_val)
            ls_val_report <= ls_val;
    
            
    
endmodule
