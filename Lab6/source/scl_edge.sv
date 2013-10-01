module scl_edge
	(
	input wire clk,
	input wire n_rst,
	input wire scl,
	output wire rising_edge_found,
	output wire falling_edge_found
	)

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			//reset everything
		end else begin
			//stuff
		end
	end
endmodule
