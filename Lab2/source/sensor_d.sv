// $Id: $
// File name:   sensor_d.sv
// Created:     8/28/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry

module sensor_d
	(
	input wire [3:0] sensors,
	output wire error
	);

	wire int_and1;
	wire int_and2;

	assign int_and1 = (sensors[3]==1'b1 && sensors[1]==1'b1) ? {1'b1} : 1'b0;
	assign int_and2 = (sensors[2]==1'b1 && sensors[1]==1'b1) ? {1'b1} : 1'b0;
	assign error = (sensors[0]==1'b1 || int_and1==1'b1 || int_and2==1'b1) ? {1'b1} : 1'b0;


endmodule

