onerror {resume}
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[39:0]} n7_mag
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[63:0]} D
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[48:32]} pow_strip
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[56:41]} pow_strip001
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[127:64]} D_upper
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[79:40]} n7_phase_full
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[31:16]} n14_real
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 84 -max 390463000.0 -min -391578000.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/stream_o_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/stream_o_tlast
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/stream_o_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/stream_o_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/trigger_tlast
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/trigger_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/trigger_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {223315000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 709
configure wave -valuecolwidth 201
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
WaveRestoreZoom {222217424 ps} {224838059 ps}
