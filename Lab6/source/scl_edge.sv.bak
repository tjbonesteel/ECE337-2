module scl_edge
	(
	input wire clk,
	input wire n_rst,
	input wire scl,
	output wire rising_edge_found,
	output wire falling_edge_found
	);

	reg a;
	reg b;

	assign rising_edge_found = (a & !b);
	assign falling_edge_found = (!a& b);

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			a <= 1'b0;
			b <= 1'b0;
		end else begin
			a <= scl;
			b <= a;
		end
	end
endmodule
