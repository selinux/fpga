//
// Copyright 2015 Ettus Research
//
// Settings register with AXI stream output.

module axi_setting_reg #(
  parameter ADDR = 0,
  parameter AWIDTH = 8,
  parameter WIDTH = 32,
  parameter DATA_AT_RESET = 0,
  parameter VALID_AT_RESET = 0, // Assert tvalid at reset
  parameter REPEATS = 0,        // Continuously assert tvalid after first write
  parameter MSB_ALIGN = 0)      // Shift data to the left to be aligned with MSB
(
  input clk, input reset, 
  input set_stb, input [AWIDTH-1:0] set_addr, input [31:0] set_data,
  output reg [WIDTH-1:0] o_tdata, output o_tlast, output reg o_tvalid, input o_tready
);

  always @(posedge clk) begin
    if (reset) begin
      o_tdata  <= DATA_AT_RESET;
      o_tvalid <= VALID_AT_RESET;
    end else begin
      if (set_stb & (ADDR==set_addr)) begin
        o_tdata  <= (MSB_ALIGN == 0) ? set_data[WIDTH-1:0] : set_data[31:32-WIDTH];
        o_tvalid <= 1'b1;
      end
      if (o_tvalid & o_tready) begin
        o_tvalid <= 1'b0;
      end
      if (o_tvalid & REPEATS) begin
        o_tvalid <= 1'b1;
      end
    end
  end

  assign o_tlast = 1'b0;

endmodule