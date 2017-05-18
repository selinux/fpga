
module lora_detect (
                      input radio_clk,
                      input bus_clk,
                      input rx_i,
                      input rx_q,
                      input vita_time,
                      output lora_trigger_out
      );

   assign lora_trigger_out = bus_clk;
   
endmodule // lora_detect
