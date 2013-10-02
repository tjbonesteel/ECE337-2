`timescale 1ns / 10ps

module tb_scl_edge();

	// Define parameters
	parameter CLK_PERIOD				= 2.5;
  
  reg tb_clk;
	reg tb_n_rst;
	reg tb_scl;
	reg tb_rising_edge_found;
	reg tb_falling_edge_found;
	
	scl_edge DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.scl(tb_scl),
		.rising_edge_found(tb_rising_edge_found),
		.falling_edge_found(tb_falling_edge_found)
	);
	
	
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end
	
	
	initial
	begin 
		// Initilize all inputs
		tb_n_rst				= 1'b0; // Initially inactive
		tb_scl	= 1'b1; // Initially idle
		
		
		// Get away from Time = 0
		#0.1; 
		tb_n_rst = 1'b1;
		#(CLK_PERIOD*2);
		tb_scl = 1'b0;
		#(CLK_PERIOD*3);
		tb_scl = 1'b1;
		#(CLK_PERIOD*2);
		tb_scl = 1'b0;
		#(CLK_PERIOD);
		tb_scl = 1'b1;
		#(CLK_PERIOD);
		tb_scl = 1'b0;
		
		
		
	end 

   

endmodule
