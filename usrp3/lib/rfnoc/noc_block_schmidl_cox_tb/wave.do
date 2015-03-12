onerror {resume}
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[39:0]} n7_mag
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[63:0]} D
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[48:32]} pow_strip
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tdata[56:41]} pow_strip001
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2 { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata[127:64]} D_upper
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata[79:40]} n7_phase_full
quietly virtual signal -install /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox { /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[31:16]} n14_real
quietly WaveActivateNextPane {} 0
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/div_corr_2_pow_2/m_axis_dout_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/i_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/i_tlast
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/i_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/i_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n0_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n0_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n1_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n1_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n2_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n2_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n3_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n3_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n4_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n4_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n5_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n5_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n6_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n6_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n8_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n8_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n9_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n9_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n10_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n10_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n11_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n12_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n12_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n13_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n15_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n15_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n16_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n16_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n17_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n17_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n18_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n18_tready
add wave -noupdate -format Analog-Step -height 84 -max 65535.0 -radix unsigned /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tdata
add wave -noupdate -format Analog-Step -height 84 -max 8162.0 -min -8144.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i1_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i0_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i1_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/i1_tvalid
add wave -noupdate -format Analog-Step -height 84 -max 2496.9999999999995 -min -60.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/o_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/o_tlast
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/o_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/o_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/thresh_met
add wave -noupdate -format Analog-Step -height 84 -max 65535.0 -radix unsigned /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/max_val
add wave -noupdate -format Analog-Step -height 84 -max 2497.0 -min -3215.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/max_phase
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/plateau_counter
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/edge_counter
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/edge_found
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/found_burst
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/burst_offset
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/plateau_detector_3000_inst/burst_phase
add wave -noupdate -format Analog-Step -height 84 -max 1.5099799999999999e+23 -min -1.4883e+23 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_phase_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_phase_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_phase_tready
add wave -noupdate -format Analog-Step -height 84 -max 1.2089200000000001e+24 -min 7.22751e+18 -radix unsigned /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_mag_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_mag_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_mag_tready
add wave -noupdate -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n7_tdata
add wave -noupdate -format Analog-Step -height 84 -max 5116.0 -min -5161.0 -radix decimal /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_real
add wave -noupdate -radix decimal -childformat {{{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[31]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[30]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[29]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[28]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[27]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[26]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[25]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[24]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[23]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[22]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[21]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[20]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[19]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[18]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[17]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[16]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[15]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[14]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[13]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[12]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[11]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[10]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[9]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[8]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[7]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[6]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[5]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[4]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[3]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[2]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[1]} -radix decimal} {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[0]} -radix decimal}} -subitemconfig {{/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[31]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[30]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[29]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[28]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[27]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[26]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[25]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[24]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[23]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[22]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[21]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[20]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[19]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[18]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[17]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[16]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[15]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[14]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[13]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[12]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[11]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[10]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[9]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[8]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[7]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[6]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[5]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[4]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[3]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[2]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[1]} {-height 17 -radix decimal} {/noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata[0]} {-height 17 -radix decimal}} /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tdata
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n14_tready
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/n13_tvalid
add wave -noupdate /noc_block_schmidl_cox_tb/inst_noc_block_schmidl_cox/inst_schmidl_cox/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {220565000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 764
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
WaveRestoreZoom {215798273 ps} {226976617 ps}
