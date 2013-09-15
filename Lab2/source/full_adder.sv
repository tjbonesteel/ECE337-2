// $Id: $
// File name:   full_adder.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry


module full_adder
       (
       input wire a,
       input wire b,
       input wire c_in,
       output wire s,
       output wire c_out
       );

       assign s = c_in ^ ( a ^ b );
       assign c_out = ((c_in==1'b0) && b==1'b1 && a==1'b1) || ( c_in==1'b1 && (b==1'b1 && a==1'b1));

endmodule

