//
// Copyright 2015 Ettus Research
//
// Designed to work with 802.11 short preamble.
//
// Algorithm: Wait until threshold is exceeded for a set number of samples, find plateau max, then trigger when
//            metric falls back down to 0.875*(plateau max). The trigger should be aligned to approximately 32 samples
//            after the end of the short preamble (downstream blocks should adjust for this offset).
//            Finally, wait for long preamble to pass before starting search again.

module plateau_detector
#(
  parameter WINDOW_LEN = 64,
  parameter PREAMBLE_LEN = 160)
(
  input clk, input reset,
  input [15:0] threshold,
  input eof,
  input [15:0] d_metric_tdata,
  input d_metric_tvalid, output d_metric_tready,
  input [15:0] phase_tdata, input phase_tvalid, output phase_tready,
  output [31:0] trigger_phase_tdata, output trigger_phase_tlast, output trigger_phase_tvalid, input trigger_phase_tready
);

  localparam PLATEAU_LEN              = PREAMBLE_LEN - 2*WINDOW_LEN;
  localparam THRESHOLD_EXCEEDED_COUNT = 4; // Determined empirically. Not too short to be useless, not too long to cause missed detections.

  // D metric moving average
  wire [20:0] d_metric_sum;
  wire [15:0] d_metric_avg_tdata = d_metric_sum[20:5]; // Divide by 32
  wire d_metric_avg_tvalid;
  wire phase_avg_tvalid;
  wire output_ready;
  moving_sum #(.MAX_LEN_LOG2(5), .WIDTH(16)) moving_sum_d_metric (
    .clk(clk), .reset(reset), .clear(),
    .len(16'd32),
    .i_tdata(d_metric_tdata), .i_tlast(), .i_tvalid(d_metric_tvalid), .i_tready(d_metric_tready),
    .o_tdata(d_metric_sum), .o_tlast(), .o_tvalid(d_metric_avg_tvalid), .o_tready(phase_avg_tvalid & output_ready));

  // Phase moving average
  localparam PHASE_DIV_FACTOR = $clog2(WINDOW_LEN)+5; // window length * 32 to get final per sample phase
  wire [20:0] phase_sum;
  wire [15:0] phase_avg_tdata = phase_sum[20:5];
  //wire [15:0] phase_avg_tdata = {{(16-PHASE_DIV_FACTOR){phase_sum[20]}},phase_sum[20:PHASE_DIV_FACTOR]}; // sign extend
  moving_sum #(.MAX_LEN_LOG2(5), .WIDTH(16)) moving_sum_phase (
    .clk(clk), .reset(reset), .clear(),
    .len(16'd32),
    .i_tdata(phase_tdata), .i_tlast(), .i_tvalid(phase_tvalid), .i_tready(phase_tready),
    .o_tdata(phase_sum), .o_tlast(), .o_tvalid(phase_avg_tvalid), .o_tready(d_metric_avg_tvalid & output_ready));

  // Register outputs
  reg trigger;
  reg [15:0] trigger_offset;
  reg [15:0] max_phase;
  axi_fifo_flop #(.WIDTH(33)) axi_fifo_flop_output (
    .clk(clk), .reset(reset), .clear(),
    .i_tdata({trigger, trigger_offset, max_phase}), .i_tvalid(d_metric_avg_tvalid & phase_avg_tvalid), .i_tready(output_ready),
    .o_tdata({trigger_phase_tlast, trigger_phase_tdata}), .o_tvalid(trigger_phase_tvalid), .o_tready(trigger_phase_tready),
    .occupied(), .space());

  wire thresh_exceeded = d_metric_avg_tdata > threshold;
  reg  [19:0] max_val;
  wire [19:0] max_val_90 = max_val - max_val[19:3]; // Actually 87.5%

  reg [$clog2(PREAMBLE_LEN)+1:0] thresh_exceeded_cnt, max_cnt;

  reg [1:0] state;
  localparam S_WAIT_EXCEED_THRESH   = 2'd0;
  localparam S_VALIDATE             = 2'd1;
  localparam S_TRIGGER              = 2'd2;
  localparam S_WAIT_FOR_EOB         = 2'd3;

  always @(posedge clk) begin
    if (reset) begin
      thresh_exceeded_cnt <= 'd0;
      max_val             <= 'd0;
      max_phase           <= 'd0;
      max_cnt             <= 'd0;
      trigger_offset      <= 'd0;
      trigger             <= 1'b0;
      state               <= S_WAIT_EXCEED_THRESH;
    end else begin
      if (d_metric_avg_tvalid & phase_avg_tvalid & output_ready) begin
        case(state)
          // Wait for threshold to be exceeded
          S_WAIT_EXCEED_THRESH : begin
            thresh_exceeded_cnt <= 'd0;
            max_val             <= 'd0;
            max_phase           <= 'd0;
            max_cnt             <= 'd0;
            trigger_offset      <= 'd0;
            trigger             <= 1'b0;
            if (thresh_exceeded) begin
              state <= S_VALIDATE;
            end
          end

          // Validate that the threshold was exceeded due to a legitimate signal
          // and not a noise spike.
          S_VALIDATE : begin
            if (thresh_exceeded) begin
              if (thresh_exceeded_cnt > THRESHOLD_EXCEEDED_COUNT-1) begin
                thresh_exceeded_cnt <= thresh_exceeded_cnt + 1;
                state               <= S_TRIGGER;
              end else begin
                thresh_exceeded_cnt <= thresh_exceeded_cnt + 1;
              end
            end else begin
              state <= S_WAIT_EXCEED_THRESH;
            end
          end

          // Latch max D metric and trigger when we hit ~90% of max value.
          // Abort if this process takes longer than the short preamble length.
          S_TRIGGER : begin
            if (d_metric_avg_tdata > max_val) begin
              max_val   <= d_metric_avg_tdata;
              max_phase <= phase_avg_tdata;
              max_cnt   <= thresh_exceeded_cnt;
            end
            thresh_exceeded_cnt <= thresh_exceeded_cnt + 1;
            if (d_metric_avg_tdata < max_val_90) begin
              trigger        <= 1'b1;
              trigger_offset <= thresh_exceeded_cnt - max_cnt;
              state          <= S_WAIT_FOR_EOB;
            end else if (thresh_exceeded_cnt > PREAMBLE_LEN) begin
              state          <= S_WAIT_EXCEED_THRESH;
            end
          end

          // Wait for end of packet burst
          S_WAIT_FOR_EOB : begin
            trigger           <= 1'b0;
            if (eof) begin
              state <= S_WAIT_EXCEED_THRESH;
            end
          end
          
          default : state <= S_WAIT_EXCEED_THRESH;
        endcase
      end
    end
  end

endmodule