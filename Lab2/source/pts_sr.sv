// $Id: $
// File name:   pts_sr.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry


module pts_sr
       (
       input wire clk,
       input wire n_rst,
       input wire shift_enable,
	   input wire load_enable,
	   input wire [3:0] parallel_in,
       output wire serial_out
       );

		reg [3:0] buffer;

		always @ (posedge clk, negedge n_rst) begin
		  if (n_rst==0) begin
		    buffer[3:0] <= 4'b1111;
		  end else if (shift_enable == 0 || load_enable == 0) begin
		    buffer[3:0] <= buffer[3:0];
		  end else begin		    
			  buffer[3:0] <= parallel_in[3:0];
      	  end
		end

		assign serial_out = buffer[3:0];

endmodule

