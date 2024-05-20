#s file is a general .xdc for the PYNQ-Z2 board 
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal 125 MHz

set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sys_clk }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sys_clk }];

##Switches

set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { sliding_sw0 }]; #IO_L7N_T1_AD2N_35 Sch=sw[0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets sliding_sw0_IBUF];
set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L7P_T1_AD2P_35 Sch=sw[1]

##RGB LEDs

set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { rgb_LED[2] }]; #IO_L22N_T3_AD7N_35 Sch=led4_b
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports {  rgb_LED[1] }]; #IO_L16P_T2_35 Sch=led4_g
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports {  rgb_LED[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=led4_r

