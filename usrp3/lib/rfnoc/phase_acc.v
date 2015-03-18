//
// Copyright 2014 Ettus Research LLC
//

module phase_acc
  #(parameter WIDTH = 16)
   (input clk, input reset, input clear,
    input [WIDTH-1:0] i_tdata, input i_tlast, input i_tvalid, output i_tready,
    output [WIDTH-1:0] o_tdata, output o_tlast, output o_tvalid, input o_tready);

   reg signed [WIDTH-1:0]     acc, phase_inc, max_acc;
   localparam ST_WAIT_FOR_TRIG = 1'd0;
   localparam ST_TRIG = 1'd1;
   //localparam [WIDTH-1:0] phase_max = 2*(2^(WIDTH-3))
   reg state;
   

   always @(posedge clk)
   begin
   	if(reset | clear)
	begin
		acc <= 0;
		phase_inc <= 0;
		max_acc <= 16'd8192;
	end
	else if(i_tvalid & o_tready)
	begin
	if(i_tlast)
	begin
		acc <= {WIDTH{1'b0}};
		phase_inc <= i_tdata;
	end
	else
		if(acc > 16'sd16383 || acc < -16'sd16383)
			acc <= 0;
		else
			acc <= acc + phase_inc;
	end
   end
   
   assign i_tready = o_tready;
   assign o_tvalid = i_tvalid;

   assign o_tlast = i_tlast;

   assign o_tdata = i_tlast ? {WIDTH{1'b0}} : acc;
   
   
endmodule // phase_acc

    