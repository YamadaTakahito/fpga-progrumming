# clock signal
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports { CLK }];
create_clock -add -name sys_clk_ipn -period 8.00 -waveform {0 4} [get_ports { CLK }];

# Reset
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports { RST }];

# LEDs
set_property -dict { PACKAGE_PIN M14  IOSTANDARD LVCMOS33 } [get_ports { LED[0] }];
set_property -dict { PACKAGE_PIN M15  IOSTANDARD LVCMOS33 } [get_ports { LED[1] }];
set_property -dict { PACKAGE_PIN G14  IOSTANDARD LVCMOS33 } [get_ports { LED[2] }];
set_property -dict { PACKAGE_PIN D18  IOSTANDARD LVCMOS33 } [get_ports { LED[3] }];