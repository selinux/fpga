//
// Copyright 2015 Ettus Research
//

module periodic_framer #(
  parameter SR_FRAME_LEN=0,
  parameter SR_GAP_LEN=1,
  parameter SR_OFFSET=2,
  parameter SR_NUMBER_SYMBOLS_MAX=3,
  parameter SR_NUMBER_SYMBOLS_SHORT=4,
  parameter WIDTH=32)
(
  input clk, input reset, input clear,
  input set_stb, input [7:0] set_addr, input [31:0] set_data,
  input [WIDTH-1:0] stream_i_tdata, input stream_i_tlast, input stream_i_tvalid, output stream_i_tready,
  input [31:0] trigger_tdata, input trigger_tlast, input trigger_tvalid, output trigger_tready,
  output [WIDTH-1:0] stream_o_tdata, output stream_o_tlast, output stream_o_tvalid, input stream_o_tready,
  output reg sof, output reg eof);

  wire [15:0] frame_len;
  wire [15:0] gap_len;
  wire [15:0] offset;

  wire [15:0] numsymbols_max, numsymbols_thisburst, numsymbols_short;
  wire [15:0] burst_len;
  wire        set_numsymbols;
  wire        consume;
  reg  [15:0] counter;
  reg  [15:0] numsymbols;

  setting_reg #(.my_addr(SR_FRAME_LEN), .width(16)) reg_frame_len (
    .clk(clk), .rst(reset), .strobe(set_stb), .addr(set_addr), .in(set_data),
    .out(frame_len), .changed());

  setting_reg #(.my_addr(SR_GAP_LEN), .width(16)) reg_gap_len (
    .clk(clk), .rst(reset), .strobe(set_stb), .addr(set_addr), .in(set_data),
    .out(gap_len), .changed());

  setting_reg #(.my_addr(SR_OFFSET), .width(16)) reg_offset (
    .clk(clk), .rst(reset), .strobe(set_stb), .addr(set_addr), .in(set_data),
    .out(offset), .changed());

  setting_reg #(.my_addr(SR_NUMBER_SYMBOLS_MAX), .width(16)) reg_max_symbols (
    .clk(clk), .rst(reset), .strobe(set_stb), .addr(set_addr), .in(set_data),
    .out(numsymbols_max), .changed());

  setting_reg #(.my_addr(SR_NUMBER_SYMBOLS_SHORT), .width(16)) reg_symbols_short (
    .clk(clk), .rst(reset), .strobe(set_stb), .addr(set_addr), .in(set_data),
    .out(numsymbols_short), .changed(set_numsymbols));

  reg [1:0]  state;
  localparam ST_WAIT_FOR_TRIG = 2'd0;
  localparam ST_DO_OFFSET     = 2'd1;
  localparam ST_FRAME         = 2'd2;
  localparam ST_GAP           = 2'd3;

  reg shorten_burst;
  always @(posedge clk) begin
    if (reset | clear) begin
      shorten_burst <= 1'b0;
    end else if (set_numsymbols) begin
      shorten_burst <= 1'b1;
    end else if(state == ST_WAIT_FOR_TRIG) begin
      shorten_burst <= 1'b0;
    end
  end

  assign numsymbols_thisburst = shorten_burst ? numsymbols_short : numsymbols_max;

  always @(posedge clk) begin
    if (reset | clear) begin
      eof        <= 1'b0;
      sof        <= 1'b0;
      counter    <= 16'd0;
      numsymbols <= 16'd0;
      state      <= ST_WAIT_FOR_TRIG;
    end else begin
      if (consume) begin
        case(state)
          ST_WAIT_FOR_TRIG : begin
            if (trigger_tlast) begin
              counter <= 16'b1;
              state   <= ST_DO_OFFSET;
            end
          end

          ST_DO_OFFSET : begin
            if (counter >= offset) begin
              sof        <= 1'b1;
              counter    <= 16'b1;
              numsymbols <= 16'd0;
              state      <= ST_FRAME;
            end else begin
              counter <= counter + 16'd1;
            end
          end

          ST_FRAME : begin
            if (counter >= frame_len) begin
              sof        <= 1'b0;
              counter    <= 1;
              numsymbols <= numsymbols + 1;
              if (numsymbols == numsymbols_thisburst-1) begin
                eof      <= 1'b1;
              end
              if (numsymbols >= numsymbols_thisburst) begin
                state <= ST_WAIT_FOR_TRIG;
              end else begin
                state <= ST_GAP;
              end
            end else begin
              counter <= counter + 16'd1;
            end
          end

          ST_GAP : begin
            eof <= 1'b0;
            if (counter >= gap_len) begin
              state   <= ST_FRAME;
              counter <= 1;
            end else begin
              counter <= counter + 16'd1;
            end
          end
        endcase
      end
    end
  end

  assign stream_o_tdata = stream_i_tdata;
  assign stream_o_tlast = (state == ST_FRAME) & (counter >= frame_len);
  assign stream_o_tvalid = stream_i_tvalid & trigger_tvalid & (state == ST_FRAME);

  assign stream_i_tready = consume;
  assign trigger_tready = consume;
  assign consume = stream_i_tvalid & trigger_tvalid & ((state != ST_FRAME) | stream_o_tready);

endmodule // periodic_framer
