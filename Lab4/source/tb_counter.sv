`timescale 1ns / 1ns

module tb_flex_counter
       ();
      localparam CLK_PERIOD = 2.5;
      
      reg tb_clk;
      reg tb_reset;
      reg tb_count_up;
      
      
      always
      begin : CLK_GEN
        tb_clk = 1'b0;
        #(CLK_PERIOD/2);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2);
      end
		
	   counter dut(.clk(tb_clk), .n_reset(tb_reset), .count_up(tb_count_up));


initial
	begin
	  tb_rst = 1'b0; tb_count_enable =1'b1; tb_value = 4'b0011; #100;
	  tb_rst = 1'b1; tb_count_enable =1'b1; tb_value = 4'b0011; #100;
	  tb_rst = 1'b0; tb_count_enable =1'b1; tb_value = 4'b0111; #100;
	  tb_rst = 1'b1; tb_count_enable =1'b1; tb_value = 4'b0111; #100;
	  
	  
	  
  end
		
endmodule

