`timescale 1ns / 10ps

module tb_sda_sel();
  
  // Define parameters
	parameter CLK_PERIOD				= 2.5;
  
  reg tb_clk;
  reg tb_tx_out;
	reg [1:0] tb_sda_mode;
	reg tb_sda_out;
	
	sda_sel DUT
	(
		.tx_out(tb_tx_out),
		.sda_mode(tb_sda_mode),
		.sda_out(tb_sda_out)
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
	  tb_tx_out = 1'b0;
	  
		tb_sda_mode = 2'b00;
		#1;
		
		if (tb_sda_out == 1'b1) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		  
		tb_sda_mode = 2'b01;
		#1;
		
		if (tb_sda_out == 1'b0) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		  
		tb_sda_mode = 2'b10;
		#1;
		
		if (tb_sda_out == 1'b1) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		  
		tb_sda_mode = 2'b11;
		#1;
		
		if (tb_sda_out == 1'b0) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		
		tb_tx_out = 1'b1;
		
	  tb_sda_mode = 2'b10;
		#1;
		
		if (tb_sda_out == 1'b1) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		  
		tb_sda_mode = 2'b11;
		#1;
		
		if (tb_sda_out == 1'b1) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		
		tb_tx_out = 1'b0;
		
	  tb_sda_mode = 2'b10;
		#1;
		
		if (tb_sda_out == 1'b1) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		  
		tb_sda_mode = 2'b11;
		#1;
		
		if (tb_sda_out == 1'b0) begin
		  $info("passed"); 
		end else begin
		  $error("failed");
		end
		
		
	end 

   

endmodule
