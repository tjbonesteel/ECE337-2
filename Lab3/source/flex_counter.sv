// File name:   flex_counter.sv
// Author:      Nicholas Molo
// Lab Section: 337-03


module flex_counter
      #(
      parameter NUM_CNT_BITS =4
      )
      (
      input wire clk,
      input wire n_rst,
	  input wire count_enable,
	  input wire [NUM_CNT_BITS-1:0] rollover_val,
	  output wire rollover_flag
      );
	  
	  //reg tmp_rollover_flag;
	  reg [NUM_CNT_BITS-1:0] counter;

	  assign rollover_flag = (counter >= rollover_val) ? 1'b1 : 1'b0;
	  
	  always @ (posedge clk, negedge n_rst) begin
		  
		  if (n_rst==0) begin
		      counter[NUM_CNT_BITS-1:0] <= {NUM_CNT_BITS{1'b0}}; //reset flip-flops to initial values
		     // tmp_rollover_flag <= 1'b0;
		  end else begin
		  	if (count_enable == 1) begin
				
				if(counter == rollover_val) begin
				//	tmp_rollover_flag <= 1'b1;
					counter[NUM_CNT_BITS-1:0] <= {{NUM_CNT_BITS-1{1'b0}},1'b1};
				end else begin
					counter <= counter +1;
					//tmp_rollover_flag <= 1'b0;
				end
				
			end else begin
				counter <= counter;
				//tmp_rollover_flag <= tmp_rollover_flag;  
		  end
		end
	end

endmodule

