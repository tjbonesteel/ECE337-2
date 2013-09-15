module controller
  (
  input  wire clk,
  input  wire n_reset,
  input  wire dr,
  input  wire overflow,
  output reg cnt_up,
  output wire modwait,
  output reg [1:0] op,
  output reg [3:0] src1,
  output reg [3:0] src2,
  output reg [3:0] dest,
  output reg err
  );
  
  