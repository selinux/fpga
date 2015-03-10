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

module schmidl_cox
  #(parameter BASE=0)
   (input clk, input reset, input clear,
    input set_stb, input [7:0] set_addr, input [31:0] set_data,
    input [31:0] i_tdata, input i_tlast, input i_tvalid, output i_tready,
    output [31:0] o_tdata, output o_tlast, output o_tvalid, input o_tready);
   
   wire [31:0] 	  n0_tdata, n1_tdata, n2_tdata, n3_tdata, n4_tdata, n8_tdata;
   wire [31:0] 	  n12_tdata, n13_tdata, n14_tdata, n15_tdata, n16_tdata, n17_tdata, n18_tdata;
   wire [63:0]    n10_tdata, n5_tdata;
   wire [79:0]    n6_tdata, n7_tdata, n11_tdata;
   wire [39:0]    n9_tdata;
   wire 	  n0_tlast, n1_tlast, n2_tlast, n3_tlast, n4_tlast, n5_tlast, n6_tlast, n7_tlast, n8_tlast, n9_tlast;
   wire 	  n10_tlast, n11_tlast, n12_tlast, n13_tlast, n14_tlast, n15_tlast, n16_tlast, n17_tlast, n18_tlast;
   wire 	  n0_tvalid, n1_tvalid, n2_tvalid, n3_tvalid, n4_tvalid, n5_tvalid, n6_tvalid, n7_tvalid, n8_tvalid, n9_tvalid;
   wire 	  n10_tvalid, n11_tvalid, n12_tvalid, n13_tvalid, n14_tvalid, n15_tvalid, n16_tvalid, n17_tvalid, n18_tvalid;
   wire 	  n0_tready, n1_tready, n2_tready, n3_tready, n4_tready, n5_tready, n6_tready, n7_tready, n8_tready, n9_tready;
   wire 	  n10_tready, n11_tready, n12_tready, n13_tready, n14_tready, n15_tready, n16_tready, n17_tready, n18_tready;
   
   // For debug purposes
   wire [15:0] 	  n0i = n0_tdata[31:16];
   wire [15:0] 	  n0q = n0_tdata[15:0];
   
   wire [15:0] 	  n1i = n1_tdata[31:16];
   wire [15:0] 	  n1q = n1_tdata[15:0];
   
   wire [15:0] 	  n2i = n2_tdata[31:16];
   wire [15:0] 	  n2q = n2_tdata[15:0];
   
   wire [15:0] 	  n3i = n3_tdata[31:16];
   wire [15:0] 	  n3q = n3_tdata[15:0];
   
   wire [15:0] 	  n4i = n4_tdata[31:16];
   wire [15:0] 	  n4q = n4_tdata[15:0];
   
   wire [15:0] 	  n5i = n5_tdata[31:16];
   wire [15:0] 	  n5q = n5_tdata[15:0];
   
   wire [15:0] 	  n6i = n6_tdata[31:16];
   wire [15:0] 	  n6q = n6_tdata[15:0];
   
   wire [15:0] 	  n7phase = n7_tdata[31:16];
   wire [15:0] 	  n7mag = n7_tdata[15:0];
   
   split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0011), .FIFOSIZE(10)) split_head
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(i_tdata), .i_tlast(i_tlast), .i_tvalid(i_tvalid), .i_tready(i_tready),
      .o0_tdata(n0_tdata), .o0_tlast(n0_tlast), .o0_tvalid(n0_tvalid), .o0_tready(n0_tready),
      .o1_tdata(n1_tdata), .o1_tlast(n1_tlast), .o1_tvalid(n1_tvalid), .o1_tready(n1_tready),
      .o2_tready(1'b0), .o3_tready(1'b0));
   
   split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0111), .FIFOSIZE(10)) split_delayed
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(n3_tdata), .i_tlast(n3_tlast), .i_tvalid(n3_tvalid), .i_tready(n3_tready),
      .o0_tdata(n2_tdata), .o0_tlast(n2_tlast), .o0_tvalid(n2_tvalid), .o0_tready(n2_tready),
      .o1_tdata(n12_tdata), .o1_tlast(n12_tlast), .o1_tvalid(n12_tvalid), .o1_tready(n12_tready),
      .o2_tdata(n14_tdata), .o2_tlast(n14_tlast), .o2_tvalid(n14_tvalid), .o2_tready(n14_tready),
      .o3_tready(1'b0));
   
   delay #(.MAX_LEN_LOG2(8), .WIDTH(32)) delay_input
     (.clk(clk), .reset(reset), .clear(clear),
      .len(16'd16),
      .i_tdata(n0_tdata), .i_tlast(n0_tlast), .i_tvalid(n0_tvalid), .i_tready(n0_tready),
      .o_tdata(n3_tdata), .o_tlast(n3_tlast), .o_tvalid(n3_tvalid), .o_tready(n3_tready));

   conj #(.WIDTH(16)) conj
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(n2_tdata), .i_tlast(n2_tlast), .i_tvalid(n2_tvalid), .i_tready(n2_tready),
      .o_tdata(n4_tdata), .o_tlast(n4_tlast), .o_tvalid(n4_tvalid), .o_tready(n4_tready));

   cmul cmult1
     (.clk(clk), .reset(reset),
      .a_tdata(n1_tdata), .a_tlast(n1_tlast), .a_tvalid(n1_tvalid), .a_tready(n1_tready),
      .b_tdata(n4_tdata), .b_tlast(n4_tlast), .b_tvalid(n4_tvalid), .b_tready(n4_tready),
      .o_tdata(n5_tdata), .o_tlast(n5_tlast), .o_tvalid(n5_tvalid), .o_tready(n5_tready));

   wire [39:0] 	  i_ma, q_ma;
   assign n6_tdata = {i_ma, q_ma}; //40bit*2 = 80bit
   
   // moving average of I for S&C metric
   moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(32)) ma_i
     (.clk(clk), .reset(reset), .clear(clear),
      .len(16'd32),
      .i_tdata(n5_tdata[63:32]), .i_tlast(n5_tlast), .i_tvalid(n5_tvalid), .i_tready(n5_tready),
      .o_tdata(i_ma), .o_tlast(n6_tlast), .o_tvalid(n6_tvalid), .o_tready(n6_tready));
      
   // moving average of Q for S&C metric
   moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(32)) ma_q
     (.clk(clk), .reset(reset), .clear(clear),
      .len(16'd32),
      .i_tdata(n5_tdata[31:0]), .i_tlast(n5_tlast), .i_tvalid(n5_tvalid), .i_tready(),
      .o_tdata(q_ma), .o_tlast(), .o_tvalid(), .o_tready(n6_tready));

   // magnitude of delay conjugate multiply
   cordic_v5_0 c2magphase 
     (.aclk(clk), .aresetn(~reset),
      .s_axis_cartesian_tdata({n6_tdata[39:0], n6_tdata[79:40]}), .s_axis_cartesian_tlast(n6_tlast), .s_axis_cartesian_tvalid(n6_tvalid), .s_axis_cartesian_tready(n6_tready),
      .m_axis_dout_tdata(n7_tdata), .m_axis_dout_tlast(n7_tlast), .m_axis_dout_tvalid(n7_tvalid), .m_axis_dout_tready(n7_tready));
   
  
   // extract magnitude from cordic
   wire [39:0] 	  n7_tdata_mag;
   wire [39:0] 	  n7_tdata_phase;
   assign n7_tdata_mag = {n7_tdata[39:0]};
   assign n7_tdata_phase = {n7_tdata[79:40]};
   
   wire [79:0] n7_tdata_mag_square;
   assign n7_tdata_mag_square = n7_tdata_mag * n7_tdata_mag;

   
   // magnitude of input signal conjugate multiply
   complex_to_magsq #(.WIDTH(16)) cmag2
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(n12_tdata), .i_tlast(n12_tlast), .i_tvalid(n12_tvalid), .i_tready(n12_tready),
      .o_tdata(n8_tdata), .o_tlast(n8_tlast), .o_tvalid(n8_tvalid), .o_tready(n8_tready));

   wire [31:0] n8_shift_tdata;
   assign n8_shift_tdata = n8_tdata >> 1; //Somehow the complex multiplier shifts the result by 1, so we need to do that here, too
   wire [79:0] signal_energy_square = n9_tdata * n9_tdata;
   
   // moving average of input signal power
   moving_sum #(.MAX_LEN_LOG2(8), .WIDTH(32)) ma_pow
     (.clk(clk), .reset(reset), .clear(clear),
      .len(16'd32),
      .i_tdata(n8_shift_tdata), .i_tlast(n8_tlast), .i_tvalid(n8_tvalid), .i_tready(n8_tready),
      .o_tdata(n9_tdata), .o_tlast(n9_tlast), .o_tvalid(n9_tvalid), .o_tready(n9_tready));
   
   // insert fifo to solve deadlock
   axi_fifo_short #(.WIDTH(81)) fifo1
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata({n9_tlast, signal_energy_square}), .i_tvalid(n9_tvalid), .i_tready(n9_tready),
      .o_tdata({n11_tlast, n11_tdata}), .o_tvalid(n11_tvalid), .o_tready(n11_tready));
   
   wire[127:0] D_metric;
   wire D_metric_tlast;
   wire D_metric_tvalide;
   wire D_metric_tready;
   div_gen_v4_0 div_corr_2_pow_2(
      .aclk(clk), .aresetn(~reset),
      .s_axis_divisor_tdata(n7_tdata_mag_square[79:16]), .s_axis_divisor_tlast(n7_tlast), .s_axis_divisor_tvalid(n7_tvalid), .s_axis_divisor_tready(n7_tready),
      .s_axis_dividend_tdata(n11_tdata[79:16]), .s_axis_dividend_tlast(n11_tlast), .s_axis_dividend_tvalid(n11_tvalid), .s_axis_dividend_tready(n11_tready),
      .m_axis_dout_tdata(D_metric), .m_axis_dout_tlast(D_metric_tlast), .m_axis_dout_tvalid(D_metric_tvalide), .m_axis_dout_tready(D_metric_tready));
   
   plateau_detector_3000 plateau_detector_3000_inst
     (.clk(clk), .reset(reset), .clear(clear),
      .i0_tdata(D_metric[127:64]), .i0_tlast(D_metric_tlast), .i0_tvalid(D_metric_tvalide), .i0_tready(D_metric_tready),
      .o_tdata(n10_tdata), .o_tlast(n10_tlast), .o_tvalid(n10_tvalid), .o_tready(n10_tready));
   
   split_stream_fifo #(.WIDTH(32), .ACTIVE_MASK(4'b0011), .FIFOSIZE(10)) split_trig
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(n10_tdata[63:32]), .i_tlast(n10_tlast), .i_tvalid(n10_tvalid), .i_tready(n10_tready),
      .o0_tdata(n16_tdata), .o0_tlast(n16_tlast), .o0_tvalid(n16_tvalid), .o0_tready(n16_tready),
      .o1_tdata(n17_tdata), .o1_tlast(n17_tlast), .o1_tvalid(n17_tvalid), .o1_tready(n17_tready),
      .o2_tready(1'b0), .o3_tready(1'b0));

   // n18_tdata[31:16] is unused
   phase_acc #(.WIDTH(16)) phase_acc
     (.clk(clk), .reset(reset), .clear(clear),
      .i_tdata(n17_tdata[31:16]), .i_tlast(n17_tlast), .i_tvalid(n17_tvalid), .i_tready(n17_tready),
      .o_tdata(n18_tdata[15:0]), .o_tlast(n18_tlast), .o_tvalid(n18_tvalid), .o_tready(n18_tready));
   
   // phase acc on n18
   cordic_rotator cfo_corrector
     (.aclk(clk), .aresetn(~reset),
      .s_axis_phase_tdata(n18_tdata[15:0]),
      .s_axis_phase_tlast(n18_tlast),
      .s_axis_phase_tvalid(n18_tvalid),
      .s_axis_phase_tready(n18_tready),
      .s_axis_cartesian_tdata(n14_tdata),
      .s_axis_cartesian_tlast(n14_tlast),
      .s_axis_cartesian_tvalid(n14_tvalid),
      .s_axis_cartesian_tready(n14_tready),
      .m_axis_dout_tdata(n15_tdata),
      .m_axis_dout_tlast(n15_tlast),
      .m_axis_dout_tvalid(n15_tvalid),
      .m_axis_dout_tready(n15_tready));
   
   periodic_framer #(.BASE(16), .WIDTH(32)) periodic_framer
     (.clk(clk), .reset(reset), .clear(clear),
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
