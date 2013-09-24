module timer
  (
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  output wire shift_strobe,
  output wire packet_done
  );
  
  reg [3:0] value;
  reg done = 1'b0;
  int i;
  reg reset;
  reg enable=0;
  
  flex_counter CNT(.clk(clk), .n_rst(reset), .count_enable(enable), .rollover_val(value), .rollover_flag(shift_strobe));
  
  assign packet_done = done;
  
  
  always @ (clk, n_rst) begin
    
    if(1'b0 == n_rst) begin
      value <= 1'b0;
      done <= 1'b0;
      reset <= 1'b0;
      enable <= 1'b0;
    end else begin
      
      enable <=1'b1;
      reset <=1'b0;
      reset <=1'b1;
      value <= 4'b0101;
            
      for(i=0;i<9;i=i+1) begin
        reset <=1'b0;
        reset <=1'b1;        
        value <= 4'b1010;
      end
      
      done <= 1'b0;
      
    end
    
  end
  
endmodule