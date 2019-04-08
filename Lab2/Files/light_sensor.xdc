########## INPUT  ##########
# clock

set_property PACKAGE_PIN W5 [get_ports clk_fpga]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_fpga]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_fpga]
# PmodALS: light sensor
# master-in-slave-out
set_property PACKAGE_PIN B15 [get_ports {ls_miso}]
    set_property IOSTANDARD LVCMOS33 [get_ports {ls_miso}]

########## OUTPUT ##########
# CS
set_property PACKAGE_PIN A14 [get_ports {ls_cs}]
    set_property IOSTANDARD LVCMOS33 [get_ports {ls_cs}]
    #set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ls_cs_IBUF]
# sclk of light sensor
set_property PACKAGE_PIN B16 [get_ports {ls_sclk}]
    set_property IOSTANDARD LVCMOS33 [get_ports {ls_sclk}]
# seven segment display
set_property PACKAGE_PIN W7 [get_ports {sv_seg_disp[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[0]}]
set_property PACKAGE_PIN W6 [get_ports {sv_seg_disp[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[1]}]
set_property PACKAGE_PIN U8 [get_ports {sv_seg_disp[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[2]}]
set_property PACKAGE_PIN V8 [get_ports {sv_seg_disp[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[3]}]
set_property PACKAGE_PIN U5 [get_ports {sv_seg_disp[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[4]}]
set_property PACKAGE_PIN V5 [get_ports {sv_seg_disp[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[5]}]
set_property PACKAGE_PIN U7 [get_ports {sv_seg_disp[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_disp[6]}]
# seven segment connector
set_property PACKAGE_PIN U2 [get_ports {sv_seg_anode[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_anode[0]}]
set_property PACKAGE_PIN U4 [get_ports {sv_seg_anode[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_anode[1]}]
set_property PACKAGE_PIN V4 [get_ports {sv_seg_anode[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_anode[2]}]
set_property PACKAGE_PIN W4 [get_ports {sv_seg_anode[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_seg_anode[3]}]
	
# added
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]