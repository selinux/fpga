onerror {resume}
radix define fixed#3#decimal#signed -fixed -fraction 3 -signed -base signed
radix define fixed#13#decimal#signed -fixed -fraction 13 -signed -base signed
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[39:0]} n7_mag
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[63:0]} D
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[48:32]} pow_strip
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[56:41]} pow_strip001
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[127:64]} D_upper
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[79:40]} n7_phase_full
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[31:16]} n14_real
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft/inst_streaming_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/inst_streaming_fft/m_axis_data_tdata[31:16]} msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft/inst_streaming_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/inst_streaming_fft/m_axis_data_tdata[15:0]} lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/periodic_framer/stream_o_tdata[15:0]} framer_out_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/str_src_tdata[63:32]} fft_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/str_src_tdata[31:0]} fft_lsbs001
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/fft_data_o_tdata[31:16]} msbd
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/fft_data_o_tdata[15:0]} lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/s_axis_data_tdata[31:16]} fft_out_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_fft { /noc_block_schmidl_cox_tb/inst_noc_block_fft/s_axis_data_tdata[15:0]} fft_out_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/cfo_corrector { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/cfo_corrector/m_axis_dout_tdata[31:16]} cordic_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/cfo_corrector { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/cfo_corrector/m_axis_dout_tdata[15:0]} cordic_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/s_axis_data_tdata[31:16]} schmidl_out_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/s_axis_data_tdata[15:0]} schmidl_out_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/m_axis_data_tdata[31:16]} schmidl_input_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/m_axis_data_tdata[15:0]} schmidl_input_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[63:32]} noc_schmidl_out_samp1
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[31:0]} noc_schmidl_samp0
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[63:48]} samp1_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[47:32]} samp1_lsbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[31:16]} samp0_msbs
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/o_tdata[15:0]} samp0_lsbs
quietly WaveActivateNextPane {} 0
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/clk
add wave -noupdate -format Analog-Step -height 84 -max 65535.0 -radix unsigned -childformat {{{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[15]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[14]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[13]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[12]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[11]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[10]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[9]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[8]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[7]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[6]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[5]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[4]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[3]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[2]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[1]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[0]} -radix decimal}} -subitemconfig {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[15]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[14]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[13]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[12]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[11]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[10]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[9]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[8]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[7]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[6]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[5]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[4]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[3]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[2]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[1]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata[0]} {-height 17 -radix decimal}} /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata
add wave -noupdate -format Analog-Step -height 84 -max 8145.9999999999991 -min -7821.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i1_tdata
add wave -noupdate -format Analog-Step -height 84 -max 128.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/trigger_counter
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/trigger
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/thresh_met
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/max_phase
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/o_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/o_tlast
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/o_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/o_tready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {221800267 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
configure wave -valuecolwidth 123
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {2985823 ps}
