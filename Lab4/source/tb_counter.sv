`timescale 1ns / 1ns

module tb_counter
       ();
      localparam CLK_PERIOD = 2.5;
      
      reg tb_clk;
      reg tb_reset;
      reg tb_cnt_up;
      reg tb_1k;
      
      always
      begin : CLK_GEN
        tb_clk = 1'b0;
        #(CLK_PERIOD/2);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2);
      end
		
	   counter dut(.clk(tb_clk), .n_reset(tb_reset), .cnt_up(tb_cnt_up), .one_k_samples(tb_1k));
	   
	   integer i;
	   initial begin
	     tb_reset = 1'b0;
	     #2;
	     tb_reset = 1'b1;
	     #2;
	   for (i=0; i<1111; i=i+1) begin
	     tb_cnt_up = 1'b0;
	     #2;
	     tb_cnt_up = 1'b1;
	     #2;
	   end
	   end

	 endmodule