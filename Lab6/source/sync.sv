// $Id: $
// File name:   sync.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry


module sync
       (
       input wire clk,
       input wire n_reset,
       input wire async_in,
       output wire sync_out
       );
		
		reg tmp1, tmp2;

		always @ (posedge clk, negedge n_reset) begin
			if (n_reset==0) begin
		    	tmp1 <=0;
			tmp2 <=0;
			end else begin		    
				tmp1 <= async_in;
				tmp2 <= tmp1;
			end
		end
		assign sync_out = tmp2;
endmodule

