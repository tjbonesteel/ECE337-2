// $Id: $
// File name:   tb_adder16bit.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry

`timescale 1ns / 1ns

module tb_addr16bit
       ();

       wire [15:0] test_a;
       wire [15:0] test_b;
       wire test_carry_in;
       wire [15:0] test_sum;
       wire test_overflow;	
       wire no_match;

		reg [15:0] tmp_a;
		reg [15:0] tmp_b;
		reg tmp_carry_in;
		reg [15:0] tmp_sum;
		reg tmp_overflow;
		reg tmp_no_match;

	   addr16bit dut(.a(test_a), .b(test_b), .carry_in(test_carry_in), .sum(test_sum), .overflow(test_overflow));
		
		assign test_a = tmp_a;
		assign test_b = tmp_b;
		assign test_carry_in = tmp_carry_in;
		assign no_match = tmp_no_match;

initial
	begin
		tmp_a = 16'h0000;
		tmp_b = 16'h0000;
		tmp_carry_in = 1'b0;
		#50;
		tmp_sum = 16'h00;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 1 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 1 failed");
      tmp_no_match = 1;
    end		  
   
    tmp_a = 16'hFFFD;
		tmp_b = 16'h0001;
		tmp_carry_in = 1'b0;
		#50;
		tmp_sum = 16'hfffe;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 2 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 2 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'hFFFa;
		tmp_b = 16'h0002;
		tmp_carry_in = 1'b0;
		#50;
		tmp_sum = 16'hfffc;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 3 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 3 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'hFFF0;
		tmp_b = 16'hFFF0;
		tmp_carry_in = 1'b0;
		#50;
		tmp_sum = 16'hffe0;
		tmp_overflow = 1'b1;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 4 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 4 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'h0004;
		tmp_b = 16'h0009;
		tmp_carry_in = 1'b0;
		#50;
		tmp_sum = 16'h000D;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 5 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 5 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'h0000;
		tmp_b = 16'h0000;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'h01;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 6 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 6 failed");
      tmp_no_match = 1;
    end		  
   
    tmp_a = 16'hFFFD;
		tmp_b = 16'h0001;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'hffff;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 7 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 7 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'hFFFa;
		tmp_b = 16'h0002;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'hfffd;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 8 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 8 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'hFFF0;
		tmp_b = 16'hFFF0;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'hffe1;
		tmp_overflow = 1'b1;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 9 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 9 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'h0004;
		tmp_b = 16'h0009;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'h000E;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 10 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 10 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'h000F;
		tmp_b = 16'h000F;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'h001F;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 11 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 11 failed");
      tmp_no_match = 1;
    end	
    
    
    tmp_a = 16'h00FF;
		tmp_b = 16'h00FF;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'h01ff;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 12 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 12 failed");
      tmp_no_match = 1;
    end	
    
    tmp_a = 16'h0FFF;
		tmp_b = 16'h0FFF;
		tmp_carry_in = 1'b1;
		#50;
		tmp_sum = 16'h1fff;
		tmp_overflow = 1'b0;
		assert(test_sum == tmp_sum && test_overflow == tmp_overflow) begin
		  $display("test case 13 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 13 failed");
      tmp_no_match = 1;
    end	
    
    
    
    
    
    
    
    
    
    
end
		

endmodule

