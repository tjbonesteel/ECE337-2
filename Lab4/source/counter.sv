// Author:      Nicholas Molo
// Lab Section: 337-03


module counter
  (
  input wire clk,
  input wire n_reset,
  input wire cnt_up,
  output wire one_k_samples
  );
  
  reg [9:0] counter;
  
  assign one_k_samples = (counter[9:0] >= 10'b1111101000) ? 1'b1 : 1'b0;
  
  
  always @ (posedge clk, negedge n_reset) begin
   
    counter <= 1'b1;
    //if (n_reset==0) begin
    //  counter <= {10{1'b0}}; //reset flip-flops to initial values
    //end else begin
    
      if (cnt_up) begin	//create flip flop to set count value
        counter <= counter +1;
      end else begin
        counter <= counter;
      end
      
		//end
		
	end

endmodule

