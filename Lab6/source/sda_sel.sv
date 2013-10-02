module sda_sel
	(
	input wire tx_out,
	input wire [1:0] sda_mode,
	output reg sda_out
	);
	
	always @ (sda_mode) begin : MUX
		case(sda_mode)
			2'b00:
				sda_out = 1'b1; //IDLE
			2'b01:
				sda_out = 1'b0; //ACK
			2'b10:
				sda_out = 1'b1; //NACK
			2'b11:
				sda_out = tx_out;	//tx_out
		endcase
	end
endmodule
