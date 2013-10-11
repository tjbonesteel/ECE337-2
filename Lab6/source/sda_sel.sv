module sda_sel
	(
	input wire tx_out,
	input wire [1:0] sda_mode,
	output reg sda_out
	);
	
	assign sda_out = 1'b1 & (!sda_mode[1] & !sda_mode[0]) |
										1'b1 & (sda_mode[1] & !sda_mode[0]) |
										1'b0 & (!sda_mode[1] & sda_mode[0]) |
										tx_out & (sda_mode[1] & sda_mode[0]);
endmodule
