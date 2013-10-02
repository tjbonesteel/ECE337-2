module controller
	(
	input wire clk,
	input wire n_rst,
	input wire stop_found,
	input wire start_found,
	input wire byte_received,
	input wire ack_prep,
	input wire check_ack,
	input wire ack_done,
	input wire rw_mode,
	input wire address_match,
	input wire sda_in,
	output reg rx_enable,
	output reg tx_enable,
	output reg read_enable,
	output reg sda_mode [1:0],
	load_data
	);

	typedef enum bit [XX] {IDLE, XXXXXX} state_type;
	state_type state, nextstate;

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			state <= IDLE;
		end else begin
			state <= nextstate;
		end
	end

	always @ (state, stop_found, start_found, byte_received, ack_prep, check_ack, ack_done, rw_mode, address_match, sda_in ) begin : State_Logic
	nextstate = state;











	end
