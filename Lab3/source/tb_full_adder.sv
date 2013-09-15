// $Id: $
// File name:   tb_full_adder.sv
// Created:     9/3/2013
// Author:      Nicholas Molo
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry

`timescale 1ns / 1ns

module tb_full_adder
       ();
       wire test_a;
       wire test_b;
       wire test_c_in;
       wire test_s;
       wire test_c_out;
       wire no_match;
        
		reg tmp_a;
		reg tmp_b;
		reg tmp_c_in;
		reg tmp_s;
		reg tmp_c_out;
		reg tmp_no_match;
		
		full_adder dut(.a(test_a), .b(test_b), .c_in(test_c_in), .s(test_s), .c_out(test_c_out));
		
		assign test_a = tmp_a;
		assign test_b = tmp_b;
		assign test_c_in = tmp_c_in;
		assign no_match = tmp_no_match;

initial
	begin
	  
	  tmp_a = 1'b0;       //Inputs
		tmp_b = 1'b0;
		tmp_c_in = 1'b0;
		
		#50;                //Wait
		
		tmp_s = 1'b0;       //Outputs
		tmp_c_out = 1'b0;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 1 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 1 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b0;       //Inputs
		tmp_b = 1'b1;
		tmp_c_in = 1'b0;
		
		#50;                //Wait
		
		tmp_s = 1'b1;       //Outputs
		tmp_c_out = 1'b0;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 2 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 2 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b1;       //Inputs
		tmp_b = 1'b0;
		tmp_c_in = 1'b0;
		
		#50;                //Wait
		
		tmp_s = 1'b1;       //Outputs
		tmp_c_out = 1'b0;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 3 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 3 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b1;       //Inputs
		tmp_b = 1'b1;
		tmp_c_in = 1'b0;
		
		#50;                //Wait
		
		tmp_s = 1'b0;       //Outputs
		tmp_c_out = 1'b1;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 4 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 4 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b0;       //Inputs
		tmp_b = 1'b0;
		tmp_c_in = 1'b1;
		
		#50;                //Wait
		
		tmp_s = 1'b1;       //Outputs
		tmp_c_out = 1'b0;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 5 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 5 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b0;       //Inputs
		tmp_b = 1'b1;
		tmp_c_in = 1'b1;
		
		#50;                //Wait
		
		tmp_s = 1'b0;       //Outputs
		tmp_c_out = 1'b1;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 6 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 6 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b1;       //Inputs
		tmp_b = 1'b0;
		tmp_c_in = 1'b1;
		
		#50;                //Wait
		
		tmp_s = 1'b0;       //Outputs
		tmp_c_out = 1'b1;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 7 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 7 failed");
      tmp_no_match = 1;
    end
    
    tmp_a = 1'b1;       //Inputs
		tmp_b = 1'b1;
		tmp_c_in = 1'b1;
		
		#50;                //Wait
		
		tmp_s = 1'b1;       //Outputs
		tmp_c_out = 1'b1;
		
		assert(test_s == tmp_s && test_c_out == tmp_c_out) begin  //Test for correctness
		  $display("test case 8 passed!");
		  tmp_no_match = 0;
    end else begin
      $error("test case 8 failed");
      tmp_no_match = 1;
    end
      
end
		
endmodule

