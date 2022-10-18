# reset Buttom
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property PACKAGE_PIN AL8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_p]

create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

set_property PACKAGE_PIN AN12 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


############## fan define##################
#set_property IOSTANDARD LVCMOS25 [get_ports fan_pwm]
#set_property PACKAGE_PIN J10 [get_ports fan_pwm]