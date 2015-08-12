//
// Copyright 2015 National Instruments
//

module file_sink #(
  parameter SR_SWAP_SAMPLES = 0,
  parameter SR_SWAP_RE_IM = 1,
  parameter FILENAME = "")
(
  input clk_i,
  input rst_i,

  input set_stb_i,
  input [7:0] set_addr_i,
  input [31:0] set_data_i,

  input  [63:0] i_tdata,
  input  i_tlast,
  input  i_tvalid,
  output i_tready);

  integer file = 0;
  reg hdr = 1'b1;

  wire swap_samples;
  wire swap_re_im;

  wire [63:0] data_int;
  wire [63:0] data;

  setting_reg #(
    .my_addr(SR_SWAP_SAMPLES),
    .width(1))
  sr_swap_samples (
    .clk(clk_i),
    .rst(rst_i),
    .strobe(set_stb_i),
    .addr(set_addr_i),
    .in(set_data_i),
    .out(swap_samples),
    .changed());

  setting_reg #(
    .my_addr(SR_SWAP_RE_IM),
    .width(1))
  sr_swap_re_im (
    .clk(clk_i),
    .rst(rst_i),
    .strobe(set_stb_i),
    .addr(set_addr_i),
    .in(set_data_i),
    .out(swap_re_im),
    .changed());

  // We're ready as soon as the file is open
  assign i_tready = (file == 0) ? 1'b0 : 1'b1;

  // Swap samples
  assign data_int = (swap_samples) ? {i_tdata[31:0], i_tdata[63:32]} : i_tdata;

  // Swap Re and Im part
  assign data = (swap_re_im) ?
    {data_int[47:32], data_int[63:48], data_int[15:0], data_int[31:16]} : data_int;

  initial begin
    file = $fopen(FILENAME, "wb");
    if(!file)
      $error("Could not open file sink.");
    $display("File sink ready.");
  end

  always @(posedge clk_i) begin
    if(rst_i) begin
      hdr <= 1'b1;
    end
    else begin
      if(i_tvalid) begin
        if(hdr) begin
          hdr <= 1'b0;
        end
        else begin
          $fwrite(file, "%u", data);
        end
      end

      if(i_tlast) begin
        hdr <= 1'b1;
      end
    end
  end

endmodule
