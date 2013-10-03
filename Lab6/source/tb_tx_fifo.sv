`timescale 1ns / 10ps

module tb_tx_fifo();
  
  // Define parameters
	parameter CLK_PERIOD				= 2.5;
  
  reg tb_clk;
  reg tb_n_rst;
  reg tb_read_enable;
  reg [7:0] tb_read_data;
  reg tb_fifo_empty;
  reg tb_fifo_full;
  reg tb_write_enable;
  reg [7:0] write_data;
  
	tx_fifo DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.read_enable(tb_read_enable),
		.read_data(tb_read_data),
		.fifo_empty(tb_fifo_empty),
		.fifo_full(tb_fifo_full),
		.write_enable(tb_write_enable),
		.write_data(tb_write_data)
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
    tb_n_rst = 1'b0;
    #1
    tb_n_rst = 1'b1;
    
    
    
    
    
    
    
    
    
    
    
    
  end 
endmodule
