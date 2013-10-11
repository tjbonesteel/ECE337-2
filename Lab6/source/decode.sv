module decode
	(
	input wire clk,
	input wire n_rst,
	input wire scl,
	input wire sda_in,
	input wire [7:0] starting_byte,
	output reg rw_mode,
	output reg address_match,
	output reg stop_found,
	output reg start_found
	);

	reg scl_1;
	reg scl_2;
	reg sda_1;
	reg sda_2;


//	assign address_match = (starting_byte[7:1] == 7'b1111000) ? 1'b1 : 1'b0;
	//assign start_found = (scl_1 && scl_2 && !sda_1 && sda_2) ? 1'b1 : 1'b0;
	//assign stop_found =  (scl_1 && scl_2 && sda_1 && !sda_2) ? 1'b1 : 1'b0;
	//assign rw_mode = starting_byte[0];
		
	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			scl_1 <= 1'b0;
			scl_2 <= 1'b0;
			sda_1 <= 1'b0;
			sda_2 <= 1'b0;
			rw_mode <= 1'b0;
			address_match <= 1'b0;
			start_found <= 1'b0;
			stop_found <= 1'b0;
		end else begin
			scl_1 <= scl;
			scl_2 <= scl_1;
			sda_1 <= sda_in;
			sda_2 <= sda_1;
			rw_mode <= starting_byte[0];
			address_match <= (starting_byte[7:1] == 7'b1111000) ? 1'b1 : 1'b0;
			start_found <= (scl_1 && scl_2 && !sda_1 && sda_2) ? 1'b1 : 1'b0;
			stop_found <= (scl_1 && scl_2 && sda_1 && !sda_2) ? 1'b1 : 1'b0;
		end
	end
endmodule
