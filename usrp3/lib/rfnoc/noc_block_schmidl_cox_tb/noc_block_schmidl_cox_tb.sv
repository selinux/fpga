//
// Copyright 2014 Ettus Research LLC
//
`timescale 1ns/1ps

module noc_block_schmidl_cox_tb();
  // rfnoc_sim_lib options
  `define NUM_CE 2          // Redefined to correct value
  `define RFNOC_SIM_LIB_INC_AXI_WRAPPER
  `define SIMPLE_MODE 0
  `include "rfnoc_sim_lib.v" 

  /*********************************************
  ** DUT
  *********************************************/
  noc_block_schmidl_cox inst_noc_block_schmidl_cox (
    .bus_clk(bus_clk), .bus_rst(bus_rst),
    .ce_clk(ce_clk), .ce_rst(ce_rst),
    .i_tdata(ce_o_tdata[0]), .i_tlast(ce_o_tlast[0]), .i_tvalid(ce_o_tvalid[0]), .i_tready(ce_o_tready[0]),
    .o_tdata(ce_i_tdata[0]), .o_tlast(ce_i_tlast[0]), .o_tvalid(ce_i_tvalid[0]), .o_tready(ce_i_tready[0]),
    .debug());
    
  noc_block_file_source #(.FILENAME("test_data_w_padding_and_lp.bin")) inst_noc_block_file_source (
    .bus_clk(bus_clk), .bus_rst(bus_rst),
    .ce_clk(ce_clk), .ce_rst(ce_rst),
    .i_tdata(ce_o_tdata[1]), .i_tlast(ce_o_tlast[1]), .i_tvalid(ce_o_tvalid[1]), .i_tready(ce_o_tready[1]),
    .o_tdata(ce_i_tdata[1]), .o_tlast(ce_i_tlast[1]), .o_tvalid(ce_i_tvalid[1]), .o_tready(ce_i_tready[1]),
    .debug());

  localparam [ 3:0] SCHMIDL_COX_XBAR_PORT = 4'd0;
  localparam [15:0] SCHMIDL_COX_SID       = {XBAR_ADDR, SCHMIDL_COX_XBAR_PORT, 4'd0};
  localparam [ 3:0] FILE_SOURCE_XBAR_PORT = 4'd1;
  localparam [15:0] FILE_SOURCE_SID       = {XBAR_ADDR, FILE_SOURCE_XBAR_PORT, 4'd0};
  
  integer i;
  reg [31:0] payload = 32'd0;

  initial begin
    @(negedge ce_rst);
    @(posedge ce_clk);
    #1000;
    
    tb_next_dst = SCHMIDL_COX_SID;
    
    // Setup FILE_SOURCE
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_FLOW_CTRL_PKTS_PER_ACK_BASE, 32'h8000_0001});                  // Command packet to set up flow control
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_FLOW_CTRL_WINDOW_SIZE_BASE, 32'h0000_0FFF});                   // Command packet to set up source control window size
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_FLOW_CTRL_WINDOW_EN_BASE, 32'h0000_0001});                     // Command packet to set up source control window enable
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_NEXT_DST_BASE, {16'd0, SCHMIDL_COX_SID}});                       // Set next destination
    
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_NEXT_DST_BASE+1, 32'd1024}); //len
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_NEXT_DST_BASE+2, 32'd20}); //line rate. Output only every x'th cycle
    SendCtrlPacket(FILE_SOURCE_SID, {24'd0, SR_NEXT_DST_BASE+3, 32'd0}); //send out time
    
    // Setup SCHMIDL_COX
    SendCtrlPacket(SCHMIDL_COX_SID, {24'd0, SR_FLOW_CTRL_PKTS_PER_ACK_BASE, 32'h8000_0001});                  // Command packet to set up flow control
    SendCtrlPacket(SCHMIDL_COX_SID, {24'd0, SR_FLOW_CTRL_WINDOW_SIZE_BASE, 32'h0000_0FFF});                   // Command packet to set up source control window size
    SendCtrlPacket(SCHMIDL_COX_SID, {24'd0, SR_FLOW_CTRL_WINDOW_EN_BASE, 32'h0000_0001});                     // Command packet to set up source control window enable
    SendCtrlPacket(SCHMIDL_COX_SID, {24'd0, SR_NEXT_DST_BASE, {16'd0, TESTBENCH_SID}});                       // Set next destination
    
    // periodic framer settings
    SendCtrlPacket(SCHMIDL_COX_SID, {32'h10, 32'd64});  // frame_len  (FFTsize)
    SendCtrlPacket(SCHMIDL_COX_SID, {32'h11, 32'd16});  // gap_len  (CP)
    SendCtrlPacket(SCHMIDL_COX_SID, {32'h12, 32'd69}); // time offset to first frame
    SendCtrlPacket(SCHMIDL_COX_SID, {32'h13, 32'd12});  // default max number of frames
    
  end
  
  

  // Assertions

endmodule