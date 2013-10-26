module tx_sr
  (
  input wire clk,
  input wire n_rst,
  input wire falling_edge_found,
  input wire tx_enable,
  input wire [7:0] tx_data,
  input wire load_data,
  output reg tx_out
  );
  
  pts_sr #(8,1) TX(
  	.clk(clk),
  	.n_rst(n_rst),
  	.shift_enable(tx_enable && falling_edge_found),
  	.load_enable(load_data),
  	.parallel_in(tx_data),
  	.serial_out(tx_out)
  	);
  
endmodule