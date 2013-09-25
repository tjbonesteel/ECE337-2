module timer
  (
  input wire clk,
  input wire n_rst,
  input wire enable_timer,
  output wire shift_strobe,
  output wire packet_done
  );
  
 
  reg [3:0] clk_val ;//= 4'b1010;
  reg [3:0] packet_val ;//= 4'b1001;
  
  reg reset;
  reg enable;
  
  reg strobe;
  reg done;
  
  
  flex_counter CNT(.clk(clk), .n_rst(n_rst), .s_rst(reset), .count_enable(enable), .rollover_val(clk_val), .rollover_flag(strobe));
  
  flex_counter BITS(.clk(clk), .n_rst(n_rst), .s_rst(reset), .count_enable(strobe), .rollover_val(packet_val), .rollover_flag(done));

  
  assign packet_done = done;
  assign shift_strobe = strobe;
  
  always @ ( posedge clk, negedge n_rst) begin
    if(n_rst ==1'b0) begin
      reset <= 1'b0;
      enable <= 1'b0;
      clk_val <= 4'b1010;
      packet_val <= 4'b1001;
    end else begin
      clk_val <= clk_val;
      packet_val <= packet_val;
      
      if(enable_timer ==1'b1) begin
        reset <= 1'b1;
        enable <= 1'b1;
      end else if(done == 1'b1) begin
        reset <=1'b0;
        enable <= 1'b0;
      end
      
    end
  end
endmodule
  
  /*
  always @ (state, enable_timer, strobe, i) begin : State_Logic
    nextstate = state;
    
    case(state)
      IDLE: begin
        if(enable_timer == 1'b0) begin
          nextstate = IDLE;
        end else begin
          nextstate = CNT10;
        end
      end
      
      CNT10: begin
        if(strobe == 1'b0) begin
          nextstate = CNT10;
          //do nothing!
        end else begin
          if(i >=9) begin
            nextstate = DONE;
          end else begin
            nextstate = CNT10;
          end
        end
      end
      
      DONE: begin
        nextstate = IDLE;
      end
    endcase
  end
  
  always @ (state) begin : Register_Logic
    case(state)
      IDLE: begin
        enable <=1'b0;
        reset <=1'b0;        
        value <= 4'b1010;
        //strobe <= 1'b0;
        done <=1'b0;
      end
      
      CNT10: begin
        enable <=1'b1;
        reset <=1'b0;
        reset <=1'b1;        
        value <= 4'b1010;
        done <=1'b0;
      end
      
      
      DONE: begin
      end
    endcase
  end
  
endmodule

*/

/*

enable <=1'b1;
        reset <=1'b0;
        reset <=1'b1;        
        value <= 4'b1010;
  
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
            
      reset <=1'b0;
      reset <=1'b1;        
      value <= 4'b1010;      
            
            
     // for(i=0;i<9;i=i+1) begin
     //   reset <=1'b0;
      //  reset <=1'b1;        
      //  value <= 4'b1010;
      //end
      
      done <= 1'b1;
      
    end
    
  end
  
endmodule
*/