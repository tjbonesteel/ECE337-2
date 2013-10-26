
`timescale 1ns / 10ps

module tb_controller();

	// Define parameters
	parameter CLK_PERIOD				= 10;
	parameter SCL_PERIOD    = 300;
	
	reg tb_clk;
	reg tb_n_rst;
	reg tb_scl;
	reg tb_stop_found;
	reg tb_start_found;
	reg tb_byte_received;
	reg tb_ack_prep;
	reg tb_check_ack;
	reg tb_ack_done;
	reg tb_rw_mode;
	reg tb_address_match;
	reg tb_sda_in;

	reg tb_rx_enable;
	reg tb_tx_enable;
	reg tb_read_enable;
	reg [1:0] tb_sda_mode;
	reg tb_load_data;

	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end
	
	always
	begin : SCL_GEN
	    tb_scl = 1'b0;
	    #(SCL_PERIOD / 3);
	    tb_scl = 1'b1;
	    #(SCL_PERIOD / 3); 
	    tb_scl = 1'b0;
	    #(SCL_PERIOD / 3);
	end	
	

	controller DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.stop_found(tb_stop_found),
		.start_found(tb_start_found),
		.byte_received(tb_byte_received),
		.ack_prep(tb_ack_prep),
		.check_ack(tb_check_ack),
		.ack_done(tb_ack_done),
		.rw_mode(tb_rw_mode),
		.address_match(tb_address_match),
		.sda_in(tb_sda_in),
		.rx_enable(tb_rx_enable),
		.tx_enable(tb_tx_enable),
		.read_enable(tb_read_enable),
		.sda_mode(tb_sda_mode),
		.load_data(tb_load_data)
	);
	


	  


initial
begin 

		#0.1;
		
		// Chip reset
		// Activate reset
			tb_n_rst = 1'b0; 
		// wait for a few clock cycles
			@(posedge tb_clk);
			@(posedge tb_clk);
		// Release on falling edge to prevent hold time violation
			@(negedge tb_clk);
			tb_n_rst = 1'b1; 		//Release reset

//Add some space before starting the test case
@(posedge tb_clk);
@(posedge tb_clk);


//Start asserted

	tb_n_rst = 1'b1;
	tb_start_found = 1'b1;

	repeat (24) begin
		@(posedge tb_clk);
	end

	tb_n_rst = 1'b0;



end


endmodule
