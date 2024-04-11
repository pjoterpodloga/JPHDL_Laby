#########################################################################################
# CLOCK:
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_i} ];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_i}];
#########################################################################################
# RESET:
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst_i} ];
#########################################################################################
# DIP SW:
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports sw_i[0] ]
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports sw_i[1] ]
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports sw_i[2] ]
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports sw_i[3] ]
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports sw_i[4] ]
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports sw_i[5] ]
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports sw_i[6] ]
set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports sw_i[7] ]
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports start_i ]; # BTNU
#########################################################################################
# LEDs:
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { ld_o[0] }];
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { ld_o[1] }];
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { ld_o[2] }];
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { ld_o[3] }];
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { ld_o[4] }];
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { ld_o[5] }];
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { ld_o[6] }];
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { ld_o[7] }];
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { ld_o[8] }];
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { ld_o[9] }];
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports { ld_o[10] }];
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { ld_o[11] }];
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { ld_o[12] }];
set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { ld_o[13] }];
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { ld_o[14] }];
set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { ld_o[15] }];
#########################################################################################
# Voltage supply for the configuration interfaces on board:
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#########################################################################################