module timer
  (
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  output wire shift_strobe,
  output wire packet_done
  );
  
  reg value;
  reg done = 1'b0;
  int i;
  reg reset;
  
  
  flex_counter CNT(.clk(clk), .n_rst(n_rst), .count_enable(enable_timer), .rollover_val(value), .rollover_flag(shift_strobe));
  
  assign packet_done = done;
  
  
  always @ (clk, n_rst) begin
    
    if(1'b0 == n_rst) begin
      value <= 1'b0;
      done <= 1'b0;
      reset <= 1'b0;
    end else begin
      
      reset <=1'b0;
      reset <=1'b1;
      value = 5;
            
      for(i=0;i<9;i=i+1) begin
        reset <=1'b0;
        reset <=1'b1;        
        value = 10;
      end
      
      done <= 1'b1;
      
    end
    
  end
  
endmodule