module decode
	(
	input wire clk,
	input wire n_rst,
	input wire scl,
	input wire sda_in,
	input wire starting_byte[7:0],
	output wire rw_mode,
	output wire address_match,
	output wire stop_found,
	output wure start_found
	);

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			//reset everything
		end else begin
			//do other  stuff

		end

	end
endmodule
