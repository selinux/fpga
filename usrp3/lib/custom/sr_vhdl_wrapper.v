//
// Copyright 2011-2012 Ettus Research LLC
//


//----------------------------------------------------------------------
//-- A settings register is a peripheral for the settings register bus.
//-- When the settings register sees strobe abd a matching address,
//-- the outputs will be become registered to the given input bus.
//----------------------------------------------------------------------

module setting_reg_vhdl_wrapper
  #(parameter my_addr = 0, 
    parameter awidth = 8,
    parameter width = 32,
    parameter at_reset=0)
    (input clk, input rst, input strobe, input wire [awidth-1:0] addr,
     input wire [31:0] data_in, output reg [width-1:0] data_out, output reg changed);

   setting_reg #(.my_addr(SR_CORE_READBACK), .awidth(8), .width(2)) sr_wrapped_register
     (.clk(clk), .rst(rst), .strobe(strobe), .addr(addr), .in(data_in),
      .out(data_out), .changed(changed));
   

   
   
endmodule // setting_reg_vhdl_wrapper
