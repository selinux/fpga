//
// Copyright 2015 Ettus Research LLC
//

module plateau_detector_3000 
    #(parameter THRESHHOLD = 1,
      parameter PLATEAU_LEN = 120)
   (input clk, input reset, input clear,
    input [15:0] i0_tdata, input i0_tlast, input i0_tvalid, output i0_tready, //M(d)
    input [15:0] i1_tdata, input i1_tlast, input i1_tvalid, output i1_tready,
    output [15:0] o_tdata, output o_tlast, output o_tvalid, input o_tready);

    wire thresh_met = i0_tdata > THRESHHOLD;
    

    // internal registers
    reg [15:0] max_val;
    reg [15:0] max_phase;
    reg [15:0] plateau_counter;
    reg [15:0] edge_counter;
    reg edge_found;
    
    // output registers
    reg found_burst;
    reg [15:0] burst_offset;
    reg [15:0] burst_phase;
    wire do_op;


    always @(posedge (clk))
        if(reset | clear)   
            begin
                max_val <= 0;
                max_phase <= 0;
                plateau_counter <= 0;
                edge_found <= 0;
                found_burst <= 0;
                edge_counter <= 0;
            end
        else
            if(do_op)
                begin
                    if(thresh_met)
                        begin
                            plateau_counter <= plateau_counter + 1;
                            if((i0_tdata > max_val) && edge_found == 0)
                                begin
                                    edge_counter <= 0;
                                    max_val <= i0_tdata;
                                end
                            else
                                begin
                                    edge_counter <= edge_counter + 1;
                                    if(edge_counter == 5) //avoid local plateaus
                                        begin
                                        	edge_found <= 1;
                                        	max_phase <= i1_tdata;
                                        end
                                end
                        end
                     else
                        begin
                            found_burst <= 0;
                            max_val <= 0;
                            max_phase <= 0;
                            plateau_counter <= 0;
                            edge_found <= 0;
                            edge_counter <= 0;
                        end             
                
                    if(plateau_counter > PLATEAU_LEN)
                        begin
                            found_burst <= 1;
                        end
                        
                    if(found_burst == 1) //reset burst after one cycle
                        begin
                            found_burst <= 0;
                            max_val <= 0;
                            max_phase <= 0;
                            plateau_counter <= 0;
                            edge_found <= 0;
                            edge_counter <= 0;
                        end
                end
                

    assign o_tdata = max_phase;
    assign o_tlast = found_burst;

    assign do_op = (i0_tvalid & i1_tvalid & o_tready);
   
    assign o_tvalid = i0_tvalid & i1_tvalid;
   
    assign i0_tready = do_op;
    assign i1_tready = do_op;

endmodule // plateau_detector_3000