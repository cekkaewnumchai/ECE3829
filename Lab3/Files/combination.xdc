########## INPUT  ##########
# clock
set_property PACKAGE_PIN W5 [get_ports {clk_fpga}]
	set_property IOSTANDARD LVCMOS33 [get_ports {clk_fpga}]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_fpga}]
# buttons
set_property PACKAGE_PIN T18 [get_ports {sw_up}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {sw_up}]
set_property PACKAGE_PIN U17 [get_ports {sw_down}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {sw_down}]
set_property PACKAGE_PIN W19 [get_ports {sw_left}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {sw_left}]
set_property PACKAGE_PIN T17 [get_ports {sw_right}]
	 set_property IOSTANDARD LVCMOS33 [get_ports {sw_right}]
# slide switches
set_property PACKAGE_PIN V17 [get_ports {sw_voltage}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_voltage}]
set_property PACKAGE_PIN V16 [get_ports {sw_sawtooth}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_sawtooth}]
set_property PACKAGE_PIN W16 [get_ports {sw_triangle}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw_triangle}]

	
########## OUTPUT  ##########
# DAC
# sclk
set_property PACKAGE_PIN B16 [get_ports {dw_sclk}]
	set_property IOSTANDARD LVCMOS33 [get_ports {dw_sclk}]
# sync
set_property PACKAGE_PIN A14 [get_ports {dw_sync}]
	set_property IOSTANDARD LVCMOS33 [get_ports {dw_sync}]
# data 
set_property PACKAGE_PIN A16 [get_ports {dw_mosi}]
	set_property IOSTANDARD LVCMOS33 [get_ports {dw_mosi}]
# vga
# red
set_property PACKAGE_PIN N19 [get_ports {vga_r[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[3]}]
set_property PACKAGE_PIN J19 [get_ports {vga_r[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN H19 [get_ports {vga_r[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN G19 [get_ports {vga_r[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[0]}]
# green
set_property PACKAGE_PIN D17 [get_ports {vga_g[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[3]}]
set_property PACKAGE_PIN G17 [get_ports {vga_g[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[2]}]
set_property PACKAGE_PIN H17 [get_ports {vga_g[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[1]}]
set_property PACKAGE_PIN J17 [get_ports {vga_g[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[0]}]
# blue
set_property PACKAGE_PIN J18 [get_ports {vga_b[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[3]}]
set_property PACKAGE_PIN K18 [get_ports {vga_b[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN L18 [get_ports {vga_b[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN N18 [get_ports {vga_b[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[0]}]
# hsyn
set_property PACKAGE_PIN P19 [get_ports {vga_hsync}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_hsync}]
# vsyn
set_property PACKAGE_PIN R19 [get_ports {vga_vsync}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_vsync}]
    
# Seven segment
# seven segment display
set_property PACKAGE_PIN W7 [get_ports {sv_disp[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[0]}]
set_property PACKAGE_PIN W6 [get_ports {sv_disp[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[1]}]
set_property PACKAGE_PIN U8 [get_ports {sv_disp[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[2]}]
set_property PACKAGE_PIN V8 [get_ports {sv_disp[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[3]}]
set_property PACKAGE_PIN U5 [get_ports {sv_disp[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[4]}]
set_property PACKAGE_PIN V5 [get_ports {sv_disp[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[5]}]
set_property PACKAGE_PIN U7 [get_ports {sv_disp[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_disp[6]}]
# seven segment connector
set_property PACKAGE_PIN U2 [get_ports {sv_anode[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_anode[0]}]
set_property PACKAGE_PIN U4 [get_ports {sv_anode[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_anode[1]}]
set_property PACKAGE_PIN V4 [get_ports {sv_anode[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_anode[2]}]
set_property PACKAGE_PIN W4 [get_ports {sv_anode[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sv_anode[3]}]
	
	
# added
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]