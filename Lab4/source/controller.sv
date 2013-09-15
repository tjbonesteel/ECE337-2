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
  
  reg tmp_err;
  reg [1:0] tmp_op;
  reg [3:0] tmp_src1;
  reg [3:0] tmp_src2;
  reg [3:0] tmp_dest;
  
  assign err = (tmp_err || overflow);
  assign op = tmp_op;
  assign src1 = tmp_src1;
  assign src2 = tmp_src2;
  assign dest = tmp_dest;
  
  always(posedge clk, negedge n_reset) begin : Reset_Logic
    if(n_reset == 1'b0) begin
      tmp_op <= {2{1'b0}};
      tmp_src1 <= {4{1'b0}};
      tmp_src2 <= {4{1'b0}};
      tmp_dest <= {4{1'b0}};
    end else begin
      tmp_op <= tmp_op;
      tmp_src1 <= tmp_src1;
      tmp_src2 <= tmp_src2;
      tmp_dest <= tmp_dest;
    end
  end

  