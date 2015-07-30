//
// Copyright 2014 Ettus Research LLC
//

// Variables:
//     length of delay between branches (16 for 802.11a STF)
//     duration of moving average (144 for 9 STF in 802.11a)
//     delay to first symbol after peak
//     length of symbols
//     length of CP
//     number of syms

module schmidl_cox #(
  parameter SR_FRAME_LEN=0,
  parameter SR_GAP_LEN=1,
  parameter SR_OFFSET=2,
  parameter SR_NUMBER_SYMBOLS_MAX=3,
  parameter SR_NUMBER_SYMBOLS_SHORT=4)
(
  input clk, input reset, input clear,
  input set_stb, input [7:0] set_addr, input [31:0] set_data,
  input [31:0] i_tdata, input i_tlast, input i_tvalid, output i_tready,
  output [31:0] o_tdata, output o_tlast, output o_tvalid, input o_tready
);

   wire [31:0] n10_tdata, n0_tdata, n1_tdata, n2_tdata, n3_tdata, n4_tdata, n8_tdata;
   wire [31:0] n12_tdata, n13_tdata, n14_tdata, n15_tdata, n16_tdata, n17_tdata;
   wire [15:0] n18_tdata;
   wire [63:0] n5_tdata;
   wire [79:0] n6_tdata;
   wire [31:0] n7_tdata, n11_tdata;
   wire [39:0] n9_tdata;
   wire n0_tlast, n1_tlast, n2_tlast, n3_tlast, n4_tlast, n5_tlast, n6_tlast, n7_tlast, n8_tlast, n9_tlast;
   wire n10_tlast, n11_tlast, n12_tlast, n13_tlast, n14_tlast, n15_tlast, n16_tlast, n17_tlast, n18_tlast;
   wire n0_tvalid, n1_tvalid, n2_tvalid, n3_tvalid, n4_tvalid, n5_tvalid, n6_tvalid, n7_tvalid, n8_tvalid, n9_tvalid;
   wire n10_tvalid, n11_tvalid, n12_tvalid, n13_tvalid, n14_tvalid, n15_tvalid, n16_tvalid, n17_tvalid, n18_tvalid;
   wire n0_tready, n1_tready, n2_tready, n3_tready, n4_tready, n5_tready, n6_tready, n7_tready, n8_tready, n9_tready;
   wire n10_tready, n11_tready, n12_tready, n13_tready, n14_tready, n15_tready, n16_tready, n17_tready, n18_tready;

  split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0111), .FIFOSIZE(10)) split_head (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(i_tdata), .i_tlast(i_tlast), .i_tvalid(i_tvalid), .i_tready(i_tready),
    .o0_tdata(n0_tdata), .o0_tlast(n0_tlast), .o0_tvalid(n0_tvalid), .o0_tready(n0_tready),
    .o1_tdata(n1_tdata), .o1_tlast(n1_tlast), .o1_tvalid(n1_tvalid), .o1_tready(n1_tready),
    .o2_tdata(n12_tdata), .o2_tlast(n12_tlast), .o2_tvalid(n12_tvalid), .o2_tready(n12_tready),
    .o3_tready(1'b0));

  split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b011), .FIFOSIZE(10)) split_delayed (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n3_tdata), .i_tlast(n3_tlast), .i_tvalid(n3_tvalid), .i_tready(n3_tready),
    .o0_tdata(n2_tdata), .o0_tlast(n2_tlast), .o0_tvalid(n2_tvalid), .o0_tready(n2_tready),
    .o1_tdata(n14_tdata), .o1_tlast(n14_tlast), .o1_tvalid(n14_tvalid), .o1_tready(n14_tready),
    .o2_tready(1'b0), .o3_tready(1'b0));

  delay #(.MAX_LEN_LOG2(8), .WIDTH(32)) delay_input (
    .clk(clk), .reset(reset), .clear(clear),
    .len(16'd32),
    .i_tdata(n0_tdata), .i_tlast(n0_tlast), .i_tvalid(n0_tvalid), .i_tready(n0_tready),
    .o_tdata(n3_tdata), .o_tlast(n3_tlast), .o_tvalid(n3_tvalid), .o_tready(n3_tready));

  conj #(.WIDTH(16)) conj (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n2_tdata), .i_tlast(n2_tlast), .i_tvalid(n2_tvalid), .i_tready(n2_tready),
    .o_tdata(n4_tdata), .o_tlast(n4_tlast), .o_tvalid(n4_tvalid), .o_tready(n4_tready));

  cmul cmult1 (
    .clk(clk), .reset(reset),
    .a_tdata(n1_tdata), .a_tlast(n1_tlast), .a_tvalid(n1_tvalid), .a_tready(n1_tready),
    .b_tdata(n4_tdata), .b_tlast(n4_tlast), .b_tvalid(n4_tvalid), .b_tready(n4_tready),
    .o_tdata(n5_tdata), .o_tlast(n5_tlast), .o_tvalid(n5_tvalid), .o_tready(n5_tready));

  // moving average of I & Q for S&C metric
  wire [39:0] i_ma, q_ma;
  moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(16)) ma_i (
    .clk(clk), .reset(reset), .clear(clear),
    .len(16'd32),
    .i_tdata(n5_tdata[63:32]), .i_tlast(n5_tlast), .i_tvalid(n5_tvalid), .i_tready(n5_tready),
    .o_tdata(i_ma), .o_tlast(n6_tlast), .o_tvalid(n6_tvalid), .o_tready(n6_tready));
  moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(16)) ma_q (
    .clk(clk), .reset(reset), .clear(clear),
    .len(16'd32),
    .i_tdata(n5_tdata[31:0]), .i_tlast(n5_tlast), .i_tvalid(n5_tvalid), .i_tready(),
    .o_tdata(q_ma), .o_tlast(), .o_tvalid(), .o_tready(n6_tready));

  assign n6_tdata = {i_ma, q_ma};

  wire [31:0] n6_round_tdata;
  wire        n6_round_tlast, n6_round_tvalid, n6_round_tready;
  axi_round_and_clip_complex #(
    .WIDTH_IN(32),
    .WIDTH_OUT(16),
    .CLIP_BITS(7))
  round_iq_ma (
    .clk(clk), .reset(reset),
    .i_tdata(n6_tdata), .i_tlast(n6_tlast), .i_tvalid(n6_tvalid), .i_tready(n6_tready),
    .o_tdata(n6_round_tdata), .o_tlast(n6_round_tlast), .o_tvalid(n6_round_tvalid), .o_tready(n6_round_tready));

  // Magnitude of delay conjugate multiply
  complex_to_magphase complex_to_magphase (.aclk(clk), .aresetn(~reset),
    .s_axis_cartesian_tdata({n6_round_tdata[15:0], n6_round_tdata[31:16]}), // Reverse I/Q input to match Xilinx's format
    .s_axis_cartesian_tlast(n6_round_tlast), .s_axis_cartesian_tvalid(n6_round_tvalid), .s_axis_cartesian_tready(n6_round_tready),
    .m_axis_dout_tdata(n7_tdata), .m_axis_dout_tlast(n7_tlast), .m_axis_dout_tvalid(n7_tvalid), .m_axis_dout_tready(n7_tready));

  // Extract magnitude from cordic
  wire [31:0] n7_mag_tdata, n7_phase_tdata;
  wire [15:0] n7_mag_strip_tdata = n7_mag_tdata[15:0];
  wire [15:0] n7_phase_strip_tdata = n7_phase_tdata[31:16];
  wire n7_mag_tlast, n7_mag_tvalid, n7_mag_tready;
  wire n7_phase_tlast, n7_phase_tvalid, n7_phase_tready;

  split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0011), .FIFOSIZE(10))
  n7_split_mag_phase_fifo (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n7_tdata), .i_tlast(n7_tlast), .i_tvalid(n7_tvalid), .i_tready(n7_tready),
    .o0_tdata(n7_mag_tdata), .o0_tlast(n7_mag_tlast), .o0_tvalid(n7_mag_tvalid), .o0_tready(n7_mag_tready),
    .o1_tdata(n7_phase_tdata), .o1_tlast(n7_phase_tlast), .o1_tvalid(n7_phase_tvalid), .o1_tready(n7_phase_tready),
    .o2_tready(1'b0), .o3_tready(1'b0));

  wire [31:0] n7_mag_square_tdata;
  wire n7_mag_square_tlast, n7_mag_square_tvalid, n7_mag_square_tready;

  mult #(.WIDTH_A(16), .WIDTH_B(16), .WIDTH_P(32), .DROP_TOP_P(0), .LATENCY(3))
  mult_sqr_mag (
   .clk(clk), .reset(reset),
   .a_tdata(n7_mag_strip_tdata), .a_tlast(n7_mag_tlast), .a_tvalid(n7_mag_tvalid), .a_tready(n7_mag_tready),
   .b_tdata(n7_mag_strip_tdata), .b_tlast(n7_mag_tlast), .b_tvalid(n7_mag_tvalid), .b_tready(),
   .p_tdata(n7_mag_square_tdata), .p_tlast(n7_mag_square_tlast), .p_tvalid(n7_mag_square_tvalid), .p_tready(n7_mag_square_tready));

  // magnitude of input signal conjugate multiply
  complex_to_magsq #(.WIDTH(16)) cmag2 (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n12_tdata), .i_tlast(n12_tlast), .i_tvalid(n12_tvalid), .i_tready(n12_tready),
    .o_tdata(n8_tdata), .o_tlast(n8_tlast), .o_tvalid(n8_tvalid), .o_tready(n8_tready));

  // moving average of input signal power
  wire [31:0] n8_shift_tdata;
  assign n8_shift_tdata = n8_tdata >> 1; // Somehow the complex multiplier shifts the result by 1, so we need to do that here, too

  moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(32)) ma_pow (
    .clk(clk), .reset(reset), .clear(clear),
    .len(16'd32),
    .i_tdata(n8_shift_tdata), .i_tlast(n8_tlast), .i_tvalid(n8_tvalid), .i_tready(n8_tready),
    .o_tdata(n9_tdata), .o_tlast(n9_tlast), .o_tvalid(n9_tvalid), .o_tready(n9_tready));

  wire [31:0] n9_sig_energy_square_tdata;
  wire n9_sig_energy_square_tlast, n9_sig_energy_square_tvalid, n9_sig_energy_square_tready;

  mult #(.WIDTH_A(16), .WIDTH_B(16), .WIDTH_P(32), .DROP_TOP_P(0), .LATENCY(3))
  mult_sqr_energy (
    .clk(clk), .reset(reset),
    .a_tdata(n9_tdata), .a_tlast(n9_tlast), .a_tvalid(n9_tvalid), .a_tready(n9_tready),
    .b_tdata(n9_tdata), .b_tlast(n9_tlast), .b_tvalid(n9_tvalid), .b_tready(),
    .p_tdata(n9_sig_energy_square_tdata), .p_tlast(n9_sig_energy_square_tlast), .p_tvalid(n9_sig_energy_square_tvalid), .p_tready(n9_sig_energy_square_tready));

  // insert fifo to solve deadlock
  axi_fifo_short #(.WIDTH(33)) fifo_sig_energy_sqr (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata({n9_sig_energy_square_tlast, n9_sig_energy_square_tdata}), .i_tvalid(n9_sig_energy_square_tvalid), .i_tready(n9_sig_energy_square_tready),
    .o_tdata({n11_tlast, n11_tdata}), .o_tvalid(n11_tvalid), .o_tready(n11_tready),
    .occupied(), .space());

  wire[63:0] D_metric;
  wire D_metric_tlast;
  wire D_metric_tvalid;
  wire D_metric_tready;
  divide_int32 corr_sqr_div_pow_sqr(
    .aclk(clk), .aresetn(~reset),
    .s_axis_divisor_tdata(n11_tdata), .s_axis_divisor_tvalid(n11_tvalid), .s_axis_divisor_tready(n11_tready),
    .s_axis_dividend_tdata(n7_mag_square_tdata), .s_axis_dividend_tlast(n7_mag_square_tlast), .s_axis_dividend_tvalid(n7_mag_square_tvalid), .s_axis_dividend_tready(n7_mag_square_tready),
    .m_axis_dout_tdata(D_metric), .m_axis_dout_tlast(D_metric_tlast), .m_axis_dout_tvalid(D_metric_tvalid), .m_axis_dout_tready(D_metric_tready));

  plateau_detector_3000 #(.THRESHHOLD(15563)) plateau_detector_3000_inst (
    .clk(clk), .reset(reset), .clear(clear),
    .i0_tdata(D_metric), .i0_tlast(D_metric_tlast), .i0_tvalid(D_metric_tvalid), .i0_tready(D_metric_tready),
    .i1_tdata(n7_phase_strip_tdata), .i1_tlast(n7_phase_tlast), .i1_tvalid(n7_phase_tvalid), .i1_tready(n7_phase_tready),
    .o_tdata(n10_tdata[15:0]), .o_tlast(n10_tlast), .o_tvalid(n10_tvalid), .o_tready(n10_tready));

  split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0011), .FIFOSIZE(10)) split_trig (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n10_tdata), .i_tlast(n10_tlast), .i_tvalid(n10_tvalid), .i_tready(n10_tready),
    .o0_tdata(n16_tdata), .o0_tlast(n16_tlast), .o0_tvalid(n16_tvalid), .o0_tready(n16_tready),
    .o1_tdata(n17_tdata), .o1_tlast(n17_tlast), .o1_tvalid(n17_tvalid), .o1_tready(n17_tready),
    .o2_tready(1'b0), .o3_tready(1'b0));

  // n18_tdata[31:16] is unused
  phase_acc #(.WIDTH(16)) phase_acc (
    .clk(clk), .reset(reset), .clear(clear),
    .i_tdata(n17_tdata[15:0]), .i_tlast(n17_tlast), .i_tvalid(n17_tvalid), .i_tready(n17_tready),
    .o_tdata(n18_tdata), .o_tlast(n18_tlast), .o_tvalid(n18_tvalid), .o_tready(n18_tready));

  // phase acc on n18
  cordic_rotator cfo_corrector (
    .aclk(clk), .aresetn(~reset),
    .s_axis_phase_tdata(n18_tdata), .s_axis_phase_tvalid(n18_tvalid), .s_axis_phase_tready(n18_tready),
    .s_axis_cartesian_tdata(n14_tdata), .s_axis_cartesian_tlast(n14_tlast), .s_axis_cartesian_tvalid(n14_tvalid), .s_axis_cartesian_tready(n14_tready),
    .m_axis_dout_tdata(n15_tdata), .m_axis_dout_tlast(n15_tlast), .m_axis_dout_tvalid(n15_tvalid), .m_axis_dout_tready(n15_tready));

  periodic_framer  #(
    .SR_FRAME_LEN(SR_FRAME_LEN),
    .SR_GAP_LEN(SR_GAP_LEN),
    .SR_OFFSET(SR_OFFSET),
    .SR_NUMBER_SYMBOLS_MAX(SR_NUMBER_SYMBOLS_MAX),
    .SR_NUMBER_SYMBOLS_SHORT(SR_NUMBER_SYMBOLS_SHORT),
    .WIDTH(32))
  periodic_framer (
    .clk(clk), .reset(reset), .clear(clear),
    .set_stb(set_stb), .set_addr(set_addr), .set_data(set_data),
    .stream_i_tdata(n15_tdata), .stream_i_tlast(n15_tlast), .stream_i_tvalid(n15_tvalid), .stream_i_tready(n15_tready),
    .trigger_tdata(n16_tdata), .trigger_tlast(n16_tlast), .trigger_tvalid(n16_tvalid), .trigger_tready(n16_tready),
    .stream_o_tdata(n13_tdata), .stream_o_tlast(n13_tlast), .stream_o_tvalid(n13_tvalid), .stream_o_tready(n13_tready),
    .eob());

  assign o_tdata = n13_tdata;
  assign o_tlast = n13_tlast;
  assign o_tvalid = n13_tvalid;
  assign n13_tready = o_tready;

endmodule // schmidl_cox
