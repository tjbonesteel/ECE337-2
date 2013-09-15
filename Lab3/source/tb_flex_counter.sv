`timescale 1ns / 1ns

module tb_flex_counter
       ();
      localparam CLK_PERIOD = 2.5;
      
      reg tb_clk;
      reg tb_rst;
      reg tb_count_enable;
      reg [3:0] tb_value;    
      reg tb_flag;
      
      
      always
      begin : CLK_GEN
        tb_clk = 1'b0;
        #(CLK_PERIOD/2);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2);
      end
		
		flex_counter dut(.clk(tb_clk), .n_rst(tb_rst), .count_enable(tb_count_enable), .rollover_val(tb_value), .rollover_flag(tb_flag));


initial
	begin
	  tb_rst = 1'b0; tb_count_enable =1'b1; tb_value = 4'b0011; #100;
	  tb_rst = 1'b1; tb_count_enable =1'b1; tb_value = 4'b0011; #100;
	  tb_rst = 1'b0; tb_count_enable =1'b1; tb_value = 4'b0111; #100;
	  tb_rst = 1'b1; tb_count_enable =1'b1; tb_value = 4'b0111; #100;
	  
	  
	  
  end
		
endmodule

