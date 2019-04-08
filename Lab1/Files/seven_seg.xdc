# input
# slide switch
# a
set_property PACKAGE_PIN W17 [get_ports {a[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {a[3]}]
set_property PACKAGE_PIN W16 [get_ports {a[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {a[2]}]
set_property PACKAGE_PIN V16 [get_ports {a[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {a[1]}]
set_property PACKAGE_PIN V17 [get_ports {a[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {a[0]}]
# b
set_property PACKAGE_PIN W13 [get_ports {b[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]
set_property PACKAGE_PIN W14 [get_ports {b[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property PACKAGE_PIN V15 [get_ports {b[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property PACKAGE_PIN W15 [get_ports {b[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
# c
set_property PACKAGE_PIN R3 [get_ports {c[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {c[3]}]
set_property PACKAGE_PIN T2 [get_ports {c[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {c[2]}]
set_property PACKAGE_PIN T3 [get_ports {c[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {c[1]}]
set_property PACKAGE_PIN V2 [get_ports {c[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {c[0]}]
# d
set_property PACKAGE_PIN R2 [get_ports {d[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {d[3]}]
set_property PACKAGE_PIN T1 [get_ports {d[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {d[2]}]
set_property PACKAGE_PIN U1 [get_ports {d[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {d[1]}]
set_property PACKAGE_PIN W2 [get_ports {d[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {d[0]}]
# push switch
set_property PACKAGE_PIN W19 [get_ports {sel1}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sel1}]
set_property PACKAGE_PIN T17 [get_ports {sel0}]
	set_property IOSTANDARD LVCMOS33 [get_ports {sel0}]
	
# output
# seven segment display
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
# seven segment connector
set_property PACKAGE_PIN U2 [get_ports {cnt[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {cnt[0]}]
set_property PACKAGE_PIN U4 [get_ports {cnt[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {cnt[1]}]
set_property PACKAGE_PIN V4 [get_ports {cnt[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {cnt[2]}]
set_property PACKAGE_PIN W4 [get_ports {cnt[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {cnt[3]}]
	
# added
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]


	
