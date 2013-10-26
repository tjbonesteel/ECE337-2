module rx_sr
  (
  input wire clk,
  input wire n_rst,
  input wire sda_in,
  input wire rising_edge_found,
  input wire rx_enable,
  output reg [7:0] rx_data
  );
  
  stp_sr #(8,1) RX(
  	.clk(clk),
  	.n_rst(n_rst),
  	.shift_enable(rx_enable && rising_edge_found),
  	.serial_in(sda_in),
  	.parallel_out(rx_data)
  	);
  
endmodule
