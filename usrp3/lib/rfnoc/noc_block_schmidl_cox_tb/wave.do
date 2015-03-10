onerror {resume}
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[39:0]} n7_mag
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[63:0]} D
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 84 -max 112936000.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_mag
add wave -noupdate -format Analog-Step -height 84 -max 12754500000000000.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata_mag_square
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/i_ma
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/q_ma
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n6_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n6_tvalid
add wave -noupdate -format Analog-Step -height 84 -max 15152100000000000.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tready
add wave -noupdate -format Analog-Step -height 84 -max 9.2211495948163922e+18 -min -9.222510615960322e+18 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/D
add wave -noupdate -max 7.3842656383933851e+23 -min -1.0 /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tvalid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {277715100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 731
configure wave -valuecolwidth 235
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {262695731 ps} {306371049 ps}
