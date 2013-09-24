module sr_9bit
  (
  input wire clk,
  input wire n_rst,
  input wire shift_strobe,
  input wire serial_in,
  output wire [7:0] packet_data,
  output wire stop_bit
  );
  
  reg [8:0] data;
  reg enable;
  reg count = 0;
  
  stp_sr #(9,1) SHIFT(.clk(clk), .n_rst(n_rst), .shift_enable(enable), .serial_in(serial_in), .parallel_out(data));
  
    
  assign packet_data[7:0] = data[7:0];
  assign stop_bit = data[8];
  assign shift_strobe = (count >= 9)? 1'b1: 1'b0;
  
  always @ (clk, n_rst) begin
    
    if(1'b0 == n_rst) begin
      //data <= 1'b0;
      enable =1'b0;
      count = 1'b0;
    end else begin
      //data <= data;
      enable =1'b1;
      count = count +1;
    end
    
  end
  
endmodule
