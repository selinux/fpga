module zf_equalizer(input clk, input reset, input clear,
    input [31:0] i_tdata, input i_tlast, input i_tvalid, output i_tready,
    output [31:0] o_tdata, output o_tlast, output o_tvalid, input o_tready);
    
    localparam ST_WAIT_FOR_FRAME = 2'd0;
    localparam ST_ESTIMATE = 2'd1;
    localparam ST_EQUALIZE = 2'd2;
    reg [1:0] state;
    
    localparam signed MAX_POS_VALUE = 16'd32767;
    localparam signed MAX_NEG_VALUE = -16'd32767;
    
    //1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1
    reg signed [31:0] lp_rom [51:0];
    
    initial()
    	begin
    	lp[0] = {MAX_POS_VALUE, 16'b0};
    	lp[1] = {MAX_POS_VALUE, 16'b0};
    	lp[2] = {MAX_NEG_VALUE, 16'b0};
    	lp[3] = {MAX_NEG_VALUE, 16'b0};
    	lp[4] = {MAX_POS_VALUE, 16'b0};
    	lp[5] = {MAX_POS_VALUE, 16'b0};
    	lp[6] = {MAX_NEG_VALUE, 16'b0};
    	lp[7] = {MAX_POS_VALUE, 16'b0};
    	lp[8] = {MAX_NEG_VALUE, 16'b0};
    	lp[9] = {MAX_POS_VALUE, 16'b0};
    	lp[10] = {MAX_POS_VALUE, 16'b0};
    	lp[11] = {MAX_POS_VALUE, 16'b0};
    	lp[12] = {MAX_POS_VALUE, 16'b0};
    	lp[13] = {MAX_POS_VALUE, 16'b0};
    	lp[14] = {MAX_POS_VALUE, 16'b0};
    	lp[15] = {MAX_NEG_VALUE, 16'b0};
    	lp[16] = {MAX_NEG_VALUE, 16'b0};
    	lp[17] = {MAX_POS_VALUE, 16'b0};
    	lp[18] = {MAX_POS_VALUE, 16'b0};
    	lp[19] = {MAX_NEG_VALUE, 16'b0};
    	lp[20] = {MAX_POS_VALUE, 16'b0};
    	lp[21] = {MAX_NEG_VALUE, 16'b0};
    	lp[22] = {MAX_POS_VALUE, 16'b0};
    	lp[23] = {MAX_POS_VALUE, 16'b0};
    	lp[24] = {MAX_POS_VALUE, 16'b0};
    	lp[25] = {MAX_POS_VALUE, 16'b0};
    	
    	lp[26] = {16'b0, 16'b0};
    	
    	lp[27] = {MAX_POS_VALUE, 16'b0};
    	lp[28] = {MAX_NEG_VALUE, 16'b0};
    	lp[29] = {MAX_NEG_VALUE, 16'b0};
    	lp[30] = {MAX_POS_VALUE, 16'b0};
    	lp[31] = {MAX_POS_VALUE, 16'b0};
    	lp[32] = {MAX_NEG_VALUE, 16'b0};
    	lp[33] = {MAX_POS_VALUE, 16'b0};
    	lp[34] = {MAX_NEG_VALUE, 16'b0};
    	lp[35] = {MAX_POS_VALUE, 16'b0};
    	lp[36] = {MAX_NEG_VALUE, 16'b0};
    	lp[37] = {MAX_NEG_VALUE, 16'b0};
    	lp[38] = {MAX_NEG_VALUE, 16'b0};
    	lp[39] = {MAX_NEG_VALUE, 16'b0};
    	lp[40] = {MAX_NEG_VALUE, 16'b0};
    	lp[41] = {MAX_POS_VALUE, 16'b0};
    	lp[42] = {MAX_POS_VALUE, 16'b0};
    	lp[43] = {MAX_NEG_VALUE, 16'b0};
    	lp[44] = {MAX_NEG_VALUE, 16'b0};
    	lp[45] = {MAX_POS_VALUE, 16'b0};
    	lp[46] = {MAX_NEG_VALUE, 16'b0};
    	lp[47] = {MAX_POS_VALUE, 16'b0};
    	lp[48] = {MAX_NEG_VALUE, 16'b0};
    	lp[49] = {MAX_POS_VALUE, 16'b0};
    	lp[50] = {MAX_POS_VALUE, 16'b0};
    	lp[51] = {MAX_POS_VALUE, 16'b0};
    	lp[52] = {MAX_POS_VALUE, 16'b0};
    	end

endmodule
