`timescale 1ns / 1ns

module tb_moore
  ();
  localparam CLK_PERIOD = 2.5;
   
  reg tb_clk;
  reg tb_rst;
  reg tb_i;
  reg tb_o;
  
  always
  begin : CLK_GEN
    tb_clk = 1'b0;
    #(CLK_PERIOD/2);
    tb_clk = 1'b1;
    #(CLK_PERIOD/2);
  end
  
  moore dut(.clk(tb_clk), .n_rst(tb_rst), .i(tb_i), .o(tb_o));
  
  initial
  begin
    tb_rst = 1'b0;#10;
    tb_rst = 1'b1;#2;
    
    tb_i = 1'b1; #2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b0; #2;
	  tb_i = 1'b1; #2;
	  assert(tb_o == 1'b1) begin
	    $display("test case 1 passed");
    end else begin
      $error("test case 1 failed");
    end	
    
    tb_rst = 1'b0;#10;
    tb_rst = 1'b1;#2;
    
    tb_i = 1'b1; #2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b0; #2;
	  tb_i = 1'b1; #2;
	  assert(tb_o == 1'b1) begin
	    $display("test case 2 passed");
    end else begin
      $error("test case 2 failed");
    end	  

    
    tb_rst = 1'b0;#10;
    tb_rst = 1'b1;#2;
	  tb_i = 1'b1; #2; //this one
	  tb_i = 1'b1; #2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b0; #2;
	  tb_i = 1'b1; #2;
	  assert(tb_o == 1'b1) begin
	    $display("test case 3 passed");
    end else begin
      $error("test case 3 failed");
    end	
    
    tb_rst = 1'b0;#10;
    tb_rst = 1'b1;#2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b0; #2;
	  tb_i = 1'b1; #2;
	  assert(tb_o == 1'b1) begin
	    $display("test case 4 passed");
    end else begin
      $error("test case 4 failed");
    end	
	  
	  tb_rst = 1'b0;#10;
    tb_rst = 1'b1;#2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b1; #2;
	  tb_i = 1'b0; #2;
	  tb_i = 1'b1; #2;
	  assert(tb_o == 1'b1) begin
	    $display("test case 5 passed");
    end else begin
      $error("test case 5 failed");
    end	  
	  tb_i = 1'b0; #2;
	  
	end
endmodule
