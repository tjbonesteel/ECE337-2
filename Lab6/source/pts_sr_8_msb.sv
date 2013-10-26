// $Id: $
// File name:   pts_sr.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry


module pts_sr_8_msb
      #(
      parameter NUM_BITS =4,
      parameter SHIFT_MSB =1
      )
       (
       input wire clk,
       input wire n_rst,
       input wire shift_enable,
	     input wire load_enable,
	     input wire [NUM_BITS-1:0] parallel_in,
       output wire serial_out
       );

		reg [NUM_BITS-1:0] buffer;

always @ (posedge clk, negedge n_rst) begin
  
  if (n_rst==1'b0) begin
    buffer[NUM_BITS-1:0] <= {NUM_BITS{1'b1}};
  end else begin
    
    if(load_enable == 1'b1) begin
      buffer[NUM_BITS-1:0] <= parallel_in[NUM_BITS-1:0];
    end else begin
    
      if (shift_enable == 1'b1) begin
        
        if(SHIFT_MSB == 1'b1) begin
          buffer[NUM_BITS-1:0] <= {buffer[NUM_BITS-2:0], 1'b1};
        end else begin
          buffer[NUM_BITS-1:0] <= {1'b1, buffer[NUM_BITS-1:1]};
        end
        
      end else begin
        buffer<= buffer;
      end
      
    end
    
  end
  
end

		assign serial_out = (buffer[NUM_BITS-1:0]);//&SHIFT_MSB) + (buffer[0]&(~SHIFT_MSB));

endmodule

