# input
# clock
set_property PACKAGE_PIN W5 [get_ports {clk_fpga}]
    set_property IOSTANDARD LVCMOS33 [get_ports {clk_fpga}]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_fpga}]

# slide switch
# sw
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
	
# output
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

# added
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]


	
