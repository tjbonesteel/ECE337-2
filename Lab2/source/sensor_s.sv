// $Id: $
// File name:   sensor_s.sv
// Created:     8/28/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: 
// 

module sensor_s
	(
	input wire [3:0] sensors,
	output wire error
	);

	and A1 (int_and1, sensors[3], sensors[1]);
	and A2 (int_and2, sensors[2], sensors[1]);
	or OR1 (error, sensors[0], int_and1, int_and2);

endmodule

