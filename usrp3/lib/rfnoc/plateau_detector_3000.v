//
// Copyright 2015 Ettus Research LLC
//

module plateau_detector_3000 
    #(parameter THRESHHOLD = 1,
      parameter PLATEAU_LEN = 90)
   (input clk, input reset, input clear,
    input [15:0] i0_tdata, input i0_tlast, input i0_tvalid, output i0_tready, //M(d)
    input [15:0] i1_tdata, input i1_tlast, input i1_tvalid, output i1_tready,
    output [15:0] o_tdata, output o_tlast, output o_tvalid, input o_tready);

    wire thresh_met = i0_tdata > THRESHHOLD;
    
	localparam ST_WAIT_FOR_THRESH = 3'd0;
	localparam ST_WAIT_FOR_EDGE = 3'd1;
	localparam ST_SETTLE_ON_EDGE = 3'd2;
	localparam ST_WAIT_FOR_PLATEAU_END = 3'd3;
	localparam ST_COUNT_TO_FRAME_START = 3'd4;
	
	reg [2:0] state;

    // internal registers
    reg [15:0] max_val;
    reg [15:0] max_phase;
    
    reg [15:0] plateau_counter;
    reg [15:0] edge_counter;
    reg [15:0] trigger_counter;
    reg trigger;
    
    wire do_op;

    always @(posedge (clk))
        if(reset | clear)   
            begin
                max_val <= 0;
                max_phase <= 0;
                plateau_counter <= 0;
                edge_counter <= 0;
                //on edge detect wait 160 samples.
                //Therefore n14 will be at the beginning of LTF1 (CP already stripped)
                trigger_counter <= 5;
                trigger <= 0;
                state <= ST_WAIT_FOR_THRESH;
            end
        else
            if(do_op)
            	begin
            		case(state)
        			ST_WAIT_FOR_THRESH :
        			begin
        				trigger <= 0;
            			if(thresh_met)
            				state <= ST_WAIT_FOR_EDGE;
            		end
        			ST_WAIT_FOR_EDGE :
        			begin
            			plateau_counter <= plateau_counter + 1;
            			if(thresh_met == 0)
						begin
							state <= ST_WAIT_FOR_THRESH;
							plateau_counter <= 0;
						end
						else 
						begin
            			if(i0_tdata < max_val+16'd100)
            				state <= ST_SETTLE_ON_EDGE;
            			else
            				max_val <= i0_tdata;
            			end
            		end
        			ST_SETTLE_ON_EDGE :
        			begin
        				plateau_counter <= plateau_counter + 1;
            			if(thresh_met == 0)
						begin
							state <= ST_WAIT_FOR_THRESH;
							plateau_counter <= 0;
						end
            			else
						begin
		            		if(edge_counter == 3) //avoid local plateaus
		                    begin
		                     	state <= ST_WAIT_FOR_PLATEAU_END;
		                      	max_phase <= (i1_tdata>>5); //devide by 32 to get phase per sample
		                    end	
		                    else
		                   	begin
		                		if(i0_tdata > max_val+16'd100)
		                        begin
		                        	edge_counter <= 0;
		                        	max_val <= i0_tdata;
		                        	state <= ST_WAIT_FOR_EDGE;
		                        end
		                        else
		                        begin
		                        	edge_counter <= edge_counter + 1;				
		                        end
		                    end
						end
					end
					ST_WAIT_FOR_PLATEAU_END :
					begin
						trigger_counter <= trigger_counter + 1;
						plateau_counter <= plateau_counter + 1;
						if(thresh_met == 0)
						begin
							state <= ST_WAIT_FOR_THRESH;
							plateau_counter <= 0;
							trigger_counter <= 0;
						end
						else
						begin 
							if(plateau_counter > PLATEAU_LEN)
	                        begin
	                            state <= ST_COUNT_TO_FRAME_START;
	                        end
						end
					end
					ST_COUNT_TO_FRAME_START :
					begin
						trigger_counter <= trigger_counter + 1;
						if(trigger_counter == 128)
						begin
							trigger <= 1;
							state <= ST_WAIT_FOR_THRESH;
							plateau_counter <= 0;
							trigger_counter <= 0;
						end
					end
					endcase
				end
            		
    assign o_tdata = max_phase;
    assign o_tlast = trigger;

    assign do_op = (i0_tvalid & i1_tvalid & o_tready);
   
    assign o_tvalid = i0_tvalid & i1_tvalid;
   
    assign i0_tready = do_op;
    assign i1_tready = do_op;

endmodule // plateau_detector_3000