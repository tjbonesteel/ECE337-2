// $Id: $
// File name:   tb_rcv_block.sv
// Created:     20/09/2013
// Author:      Yifeng Chen
// Lab Section: 02
// Version:     2.0  Initial Design Entry
// Description: completed top level test bench provided for Lab 5

`timescale 1ns / 10ps

module tb_rcv_block();

	// Define parameters
	parameter CLK_PERIOD				= 2.5;
	parameter NORM_DATA_PERIOD	= (10 * CLK_PERIOD);
	
	localparam WORST_FAST_DATA_PERIOD = (NORM_DATA_PERIOD * 0.96);
	localparam WORST_SLOW_DATA_PERIOD = (NORM_DATA_PERIOD * 1.04);
	localparam NUM_TEST_CASES = 10;
	
	wire [7:0] tb_rx_data;
	wire tb_data_ready;
	wire tb_overrun_error;
	wire tb_framing_error;
	
	reg tb_clk;
	reg tb_n_rst;
	reg tb_serial_in;
	reg tb_data_read;
	
	integer tb_test_case;
	reg [7:0] tb_test_data;
	
	integer test_case_num; // Only used during test vector creation
	reg [1:NUM_TEST_CASES][7:0] test_cases_data;
	reg [1:NUM_TEST_CASES] test_cases_stop_bit;
	time [1:NUM_TEST_CASES] test_cases_bit_period;
	reg [1:NUM_TEST_CASES] test_cases_data_ready;
	reg [1:NUM_TEST_CASES] test_cases_framing_error;

        integer test_9_ind; // Only used during test 9
        integer test_10_ind; // Only used during test 10
	
	task send_packet;
		input  [7:0] data;
		input  stop_bit;
		input  time data_period;
		
		integer i;
	
	begin
		// Send start bit
		tb_serial_in = 1'b0;
		#data_period;
		
		// Send data bits
		for(i = 0; i < 8; i = i + 1)
		begin
			tb_serial_in = data[i];
			#data_period;
		end
		
		// Send stop bit
		tb_serial_in = stop_bit;
		#data_period;
	end
	endtask
	
	rcv_block DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.serial_in(tb_serial_in),
		.data_read(tb_data_read),
		.rx_data(tb_rx_data),
		.data_ready(tb_data_ready),
		.overrun_error(tb_overrun_error),
		.framing_error(tb_framing_error)
	);
	
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	// Test vector population
	initial
	begin
		// First test case Normal packet
		test_case_num = 1;
		test_cases_data[test_case_num] = 8'b11010101;
		test_cases_stop_bit[test_case_num] = 1'b1;
		test_cases_bit_period[test_case_num] = NORM_DATA_PERIOD;
		test_cases_data_ready[test_case_num] = 1'b1;
		test_cases_framing_error[test_case_num] = 1'b0;
		
		// Second test case Normal packet with 4% faster bit periods
		test_case_num = test_case_num + 1;
		test_cases_data[test_case_num] = 8'b11010101;
		test_cases_stop_bit[test_case_num] = 1'b1;
		test_cases_bit_period[test_case_num] = WORST_FAST_DATA_PERIOD;
		test_cases_data_ready[test_case_num] = 1'b1;
		test_cases_framing_error[test_case_num] = 1'b0;

	        // Third test case Normal packet with 4% slower bit periods
	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b11010101;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = WORST_SLOW_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;
	   
	   // 4th test case: Normal packet with framing error
	   test_case_num = test_case_num + 1;
 	   test_cases_data[test_case_num] = 8'b00101010;
	   test_cases_stop_bit[test_case_num] = 1'b0;
	   test_cases_bit_period[test_case_num] = NORM_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b0;
	   test_cases_framing_error[test_case_num] = 1'b1;

	   // 5th test case: Normal packet with overun error
	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b11101001;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = NORM_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;

	   //6,7,8th test case: multiple packets with variation in bit periods (consistency test, together they are 1 test case)
	   // fast-normal-slow-reset check
	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b10101011;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = WORST_FAST_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;

	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b10101100;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = NORM_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;

	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b10101101;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = WORST_SLOW_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;

	   //Test case 9: Check if error acculumated (if existed)
	   //To make sure the error does not accumulated, this will be a
	   //very long test. Please alter the period as you wish, 
	   // default testing case is NORM
	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b11000101;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = WORST_SLOW_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;  

	   //Test case 10: multiple packets with overrun and framing in between
	   //normal speed
	   //good packet ->overrun ->framing ->good packet -> 
	   // following setting is for the first packet
	   test_case_num = test_case_num + 1;
	   test_cases_data[test_case_num] = 8'b10100011;
	   test_cases_stop_bit[test_case_num] = 1'b1;
	   test_cases_bit_period[test_case_num] = NORM_DATA_PERIOD;
	   test_cases_data_ready[test_case_num] = 1'b1;
	   test_cases_framing_error[test_case_num] = 1'b0;
	   
	   
	end
	
	
	// Actual test bench process
	initial
	begin : TEST_PROC
		// Initilize all inputs
		tb_n_rst				= 1'b1; // Initially inactive
		tb_serial_in	= 1'b1; // Initially idle
		tb_data_read	= 1'b0; // Initially inactive
		
		// Get away from Time = 0
		#0.1; 
		
		for(tb_test_case = 1; tb_test_case <= 3; tb_test_case++)
		begin
			// Chip reset
			// Activate reset
			tb_n_rst = 1'b0; 
			// wait for a few clock cycles
			@(posedge tb_clk);
			@(posedge tb_clk);
			// Release on falling edge to prevent hold time violation
			@(negedge tb_clk);
			// Release reset
			tb_n_rst = 1'b1; 
			// Add some space before starting the test case
			@(posedge tb_clk);
			@(posedge tb_clk);
		
			// Run test case
			// Update test data indicator signal
			tb_test_data = test_cases_data[tb_test_case];
			// Send packet
			send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
			// Wait for 2 data periods to allow DUT to finish processing the packet
			#(test_cases_bit_period[tb_test_case] * 2);
			
			// Check outputs
			assert(tb_test_data == tb_rx_data)
				$info("Test case %0d: Test data correctly received", tb_test_case);
			else
				$error("Test case %0d: Test data was not correctly received", tb_test_case);
			assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
				$info("Test case %0d: DUT correctly shows no framing error", tb_test_case);
			else
				$error("Test case %0d: DUT incorrectly shows a framing error", tb_test_case);
			assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
				$info("Test case %0d: DUT correctly asserted the data ready flag", tb_test_case);
			else
				$error("Test case %0d: DUT did not correctly assert the data ready flag", tb_test_case);
			assert(1'b0 == tb_overrun_error)
				$info("Test case %0d: DUT correctly shows no overrun error", tb_test_case);
			else
				$error("Test case %0d: DUT incorrectly shows an overrun error", tb_test_case);
			
			if(1'b1 == test_cases_data_ready[tb_test_case])
			begin
				// Test case was supposed to set the data ready to a '1' -> check that it clears properly
				// Activate the data read input and wait a clock cycle for the flag to clear
				tb_data_read = 1'b1;
				#(CLK_PERIOD);
				tb_data_read = 1'b0;
				
				// Check to see if the data ready flag cleared
				@(negedge tb_clk);
				assert(1'b0 == tb_data_ready)
					$info("Test case %0d: DUT correctly cleared the data ready flag", tb_test_case);
				else
					$error("Test case %0d: DUT did not correctly clear the data ready flag", tb_test_case);
			end
		end // for (tb_test_case = 1; tb_test_case <= NUM_TEST_CASES; tb_test_case++)
	   
	   #(CLK_PERIOD*2);
	   
		
	   // Add any special cases here (such as overrun case)
	   // Test case 4: check for framing_error
	   tb_test_case = 4;
	   
	   tb_n_rst = 1'b0;
	   @(posedge tb_clk);
	   @(posedge tb_clk);

	   @(negedge tb_clk);
	   tb_n_rst = 1'b1; // release reset

	   @(posedge tb_clk);
	   @(posedge tb_clk);
	   //Run test case
	   tb_test_data = test_cases_data[tb_test_case];
	   
	   //Send packet
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   // Wait for 2 data periods to allow DUT to finish processing the packet
           #(test_cases_bit_period[tb_test_case] * 2);

	   // Check outputs
	   assert(8'b11111111 == tb_rx_data)	
	        $info("Test case %0d: Test data correctly thrown away", tb_test_case);
	   else
	        $error("Test case %0d: Test data was not correctly thrown away", tb_test_case);
           assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
	      $info("Test case %0d: DUT correctly shows no framing error", tb_test_case);
           else
	        $error("Test case %0d: DUT incorrectly shows a framing error", tb_test_case);
           assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
	        $info("Test case %0d: DUT correctly asserted the data ready flag", tb_test_case);
           else
	        $error("Test case %0d: DUT did not correctly assert the data ready flag", tb_test_case);
           assert(1'b0 == tb_overrun_error)
	        $info("Test case %0d: DUT correctly shows no overrun error", tb_test_case);
           else
	        $error("Test case %0d: DUT incorrectly shows an overrun error", tb_test_case);
	   


	   // Test case 5: Normal packet sent with overrun error
	   tb_test_case = 5;
	   tb_data_read = 1'b0;
	   
	   tb_n_rst = 1'b0;
	   @(posedge tb_clk);
	   @(posedge tb_clk);

	   @(negedge tb_clk);
	   tb_n_rst = 1'b1; // release reset
	   	   
	   @(posedge tb_clk);
	   @(posedge tb_clk);
	   //Run test case
	   tb_test_data = test_cases_data[tb_test_case];
	   
	   //Send packet
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   // Wait for 2 data periods to allow DUT to finish processing the packet
           #(test_cases_bit_period[tb_test_case] * 2);

	   // Check outputs
	   assert(tb_test_data == tb_rx_data)	
	        $info("Test case %0d.5: Test data correctly received", tb_test_case);
	   else
	        $error("Test case %0d.5: Test data was incorrectly received", tb_test_case);
           assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
	      $info("Test case %0d.5: DUT correctly shows no framing error", tb_test_case);
           else
	        $error("Test case %0d.5: DUT incorrectly shows a framing error", tb_test_case);
           assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
	        $info("Test case %0d.5: DUT correctly asserted the data ready flag", tb_test_case);
           else
	        $error("Test case %0d.5: DUT did not correctly assert the data ready flag", tb_test_case);
           assert(0'b0 == tb_overrun_error)
	        $info("Test case %0d.5: DUT correctly shows no overrun error", tb_test_case);
           else
	        $error("Test case %0d.5: DUT incorrectly shows an overrun error", tb_test_case);  // first time after reset, overrun shall be 0

	   //data_read shall be 1'b1 if corrected loaded
	   if (test_cases_data_ready[tb_test_case] == tb_data_ready)
	     begin
	        tb_data_read = 1'b0; // do not clear to test overrun		
	     end
	   

	   #(CLK_PERIOD*2); // ensure 2 clock cycle idel line

	   //Do not clear the data_read
	   //Send the second packet
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   
	   // Wait for 2 data periods to allow DUT to finish processing the packet
           #(test_cases_bit_period[tb_test_case] * 2);

	   // Check outputs
	   assert(tb_test_data == tb_rx_data)	
	        $info("Test case %0d: Test data correctly received", tb_test_case);
	   else
	        $error("Test case %0d: Test data was incorrectly received", tb_test_case);
           assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
	      $info("Test case %0d: DUT correctly shows no framing error", tb_test_case);
           else
	        $error("Test case %0d: DUT incorrectly shows a framing error", tb_test_case);
           assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
	        $info("Test case %0d: DUT correctly asserted the data ready flag", tb_test_case);
           else
	        $error("Test case %0d: DUT did not correctly assert the data ready flag", tb_test_case);
           assert(1'b1 == tb_overrun_error)
	        $info("Test case %0d: DUT correctly shows overrun error", tb_test_case);
           else
	        $error("Test case %0d: DUT incorrectly shows no overrun error", tb_test_case);  // first time after reset, overrun shall be 0

	   if(1'b1 == test_cases_data_ready[tb_test_case])
		begin
	        // Test case was supposed to set the data ready to a '1' -> check that it clears properly
	        // Activate the data read input and wait a clock cycle for the flag to clear
	           tb_data_read = 1'b1;
		   #(CLK_PERIOD);
	       	   tb_data_read = 1'b0;
				
	        // Check to see if the data ready flag cleared
	           @(negedge tb_clk);
	           assert(1'b0 == tb_data_ready)
	             $info("Test case %0d: DUT correctly cleared the data ready flag", tb_test_case);
		   else
		     $error("Test case %0d: DUT did not correctly clear the data ready flag", tb_test_case);
		end // if (1'b1 == test_cases_data_ready[tb_test_case])

	   // Test case 6: Continuous sending packets with varying data bits

	   #(CLK_PERIOD * 2);
	   tb_n_rst = 1'b0;
	   tb_data_read = 1'b0;

	   @(posedge tb_clk);
	   @(posedge tb_clk);

	   @(negedge tb_clk);
	   tb_n_rst = 1'b1; // release reset
	   	   
	   
	   
	   //Run test case
	   
	   
	   for (tb_test_case = 6; tb_test_case <= 8; tb_test_case ++)
	     begin
		tb_test_data = test_cases_data[tb_test_case];
	        @(posedge tb_clk);
		@(posedge tb_clk);
		send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
		#(test_cases_bit_period[tb_test_case]);

		#(CLK_PERIOD * 2);
		
		// Check outputs
	        assert(tb_test_data == tb_rx_data)
		        $info("Test case %6.0d: Test data correctly received", tb_test_case);
	        else
		        $error("Test case %6.0d: Test data was not correctly received", tb_test_case);
	        assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
		        $info("Test case %6.0d: DUT correctly shows no framing error", tb_test_case);
	        else
		        $error("Test case %6.0d: DUT incorrectly shows a framing error", tb_test_case);
	        assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
		        $info("Test case %6.0d: DUT correctly asserted the data ready flag", tb_test_case);
	        else
		        $error("Test case %6.0d: DUT did not correctly assert the data ready flag", tb_test_case);
	        assert(1'b0 == tb_overrun_error)
		        $info("Test case %6.0d: DUT correctly shows no overrun error", tb_test_case);
	        else
		        $error("Test case %6.0d: DUT incorrectly shows an overrun error", tb_test_case);
			
	        if(1'b1 == test_cases_data_ready[tb_test_case])
	        begin
		        // Test case was supposed to set the data ready to a '1' -> check that it clears properly
		        // Activate the data read input and wait a clock cycle for the flag to clear
		        tb_data_read = 1'b1;
		        #(CLK_PERIOD);
		        tb_data_read = 1'b0;
				
		        // Check to see if the data ready flag cleared
		        @(negedge tb_clk);
		        assert(1'b0 == tb_data_ready)
			        $info("Test case %6.0d: DUT correctly cleared the data ready flag", tb_test_case);
		        else
			        $error("Test case %6.0d: DUT did not correctly clear the data ready flag", tb_test_case);
	        end // if (1'b1 == test_cases_data_ready[tb_test_case])
	     end // for (tb_test_case = 6; tb_test_case <= 8; tb_test_case ++)

	   //Test case 9: Error accumulation Test
	   #(CLK_PERIOD * 2);
	   tb_n_rst = 1'b0;
	   tb_data_read = 1'b0;

	   @(posedge tb_clk);
	   @(posedge tb_clk);

	   @(negedge tb_clk);
	   tb_n_rst = 1'b1; // release reset

	   //Run test case
	   tb_test_case = 9;
	   	   
	   for (test_9_ind = 0; test_9_ind <= 20; test_9_ind ++)
	     begin
		tb_test_data = test_cases_data[tb_test_case];
	        @(posedge tb_clk);
		@(posedge tb_clk);
		send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
		#(test_cases_bit_period[tb_test_case] * 1.25);
		
		// Check outputs
	        assert(tb_test_data == tb_rx_data)
		        $info("Test case 9.%0d: Test data correctly received", test_9_ind);
	        else
		        $error("Test case 9.%0d: Test data was not correctly received", test_9_ind);
	        assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
		        $info("Test case 9.%0d: DUT correctly shows no framing error", test_9_ind);
	        else
		        $error("Test case 9.%0d: DUT incorrectly shows a framing error", test_9_ind);
	        assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
		        $info("Test case 9.%0d: DUT correctly asserted the data ready flag", test_9_ind);
	        else
		        $error("Test case 9.%0d: DUT did not correctly assert the data ready flag", test_9_ind);
	        assert(1'b0 == tb_overrun_error)
		        $info("Test case 9.%0d: DUT correctly shows no overrun error", test_9_ind);
	        else
		        $error("Test case 9.%0d: DUT incorrectly shows an overrun error", test_9_ind);
			
	        if(1'b1 == test_cases_data_ready[tb_test_case])
	        begin
		        // Test case was supposed to set the data ready to a '1' -> check that it clears properly
		        // Activate the data read input and wait a clock cycle for the flag to clear
		        tb_data_read = 1'b1;
		        #(CLK_PERIOD);
		        tb_data_read = 1'b0;
				
		        // Check to see if the data ready flag cleared
		        @(negedge tb_clk);
		        assert(1'b0 == tb_data_ready)
			        $info("Test case %6.0d: DUT correctly cleared the data ready flag", tb_test_case);
		        else
			        $error("Test case %6.0d: DUT did not correctly clear the data ready flag", tb_test_case);
	        end // if (1'b1 == test_cases_data_ready[tb_test_case])
	     end // for (test_9_ind = 0; test_9_ind <= 10; test_9_ind ++)

	   //Test case 10:
	   #(CLK_PERIOD * 2);
	   tb_n_rst = 1'b0;
	   tb_data_read = 1'b0;

	   @(posedge tb_clk);
	   @(posedge tb_clk);

	   @(negedge tb_clk);
	   tb_n_rst = 1'b1; // release reset
	   
	   tb_test_case = 10;
	   // Run test:
	   //9.1 normal packet:
	   tb_test_data = test_cases_data[tb_test_case];
	   
	   @(posedge tb_clk);
           @(posedge tb_clk);
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   
	   //wait for processing to finish
	   fork
	      begin: processing
		 #(test_cases_bit_period[tb_test_case]);
		 disable data_ready_10_1;
	      end
	      begin: data_ready_10_1
		 @(posedge tb_data_ready);
		 disable processing;
	      end
	   join

	   //get away from clocking edge
	   #(CLK_PERIOD * 0.7);
	   
	   // Check outputs
	   assert(tb_test_data == tb_rx_data)	
	        $info("Test case 10.1: Test data correctly received");
	   else
	        $error("Test case 10.1: Test data was incorrectly received");
           assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
	      $info("Test case 10.1: DUT correctly shows no framing error");
           else
	        $error("Test case 10.1: DUT incorrectly shows a framing error");
           assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
	        $info("Test case 10.1: DUT correctly asserted the data ready flag");
           else
	        $error("Test case 10.1: DUT did not correctly assert the data ready flag");
           assert(0'b0 == tb_overrun_error)
	        $info("Test case 10.1: DUT correctly shows no overrun error");
           else
	        $error("Test case 10.1: DUT incorrectly shows an overrun error");  // first time after reset, overrun shall be 0

	   //data_read shall be 1'b1 if corrected loaded
	   if (test_cases_data_ready[tb_test_case] == tb_data_ready)
	     begin
	        tb_data_read = 1'b0; // do not clear to test overrun		
	     end


	   // second packet: overrun error
	   @(posedge tb_clk);
	   @(posedge tb_clk);  //2 clock cycle idle line
	   
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   
	   //wait for processing to finish
	   fork
	      begin: processing_10_2
		 #(test_cases_bit_period[tb_test_case]);
		 disable data_ready_10_2;
	      end
	      begin: data_ready_10_2
		 @(posedge tb_data_ready);
		 disable processing_10_2;
	      end
	   join

	   //get away from clocking edge
	   #(CLK_PERIOD * 0.7);
	   
	   // Check outputs
	   assert(tb_test_data == tb_rx_data)	
	        $info("Test case 10.2: Test data correctly received");
	   else
	        $error("Test case 10.2: Test data was incorrectly received");
           assert(test_cases_framing_error[tb_test_case] == tb_framing_error)
	      $info("Test case 10.2: DUT correctly shows no framing error");
           else
	        $error("Test case 10.2: DUT incorrectly shows a framing error");
           assert(test_cases_data_ready[tb_test_case] == tb_data_ready)
	        $info("Test case 10.2: DUT correctly asserted the data ready flag");
           else
	        $error("Test case 10.2: DUT did not correctly assert the data ready flag");
           assert(1'b1 == tb_overrun_error)
	        $info("Test case 10.2: DUT correctly shows overrun error");
           else
	        $error("Test case 10.2: DUT incorrectly shows no overrun error");

	   // do not clear the error
	   if (test_cases_data_ready[tb_test_case] == tb_data_ready)
	     begin
	        tb_data_read = 1'b0;
		#(CLK_PERIOD);
		tb_data_read = 1'b1;

		// Check to see if the data ready flag cleared
	        @(negedge tb_clk);
	        assert(1'b0 == tb_data_ready)
		      $info("Test case 10.2: DUT correctly cleared the data ready flag");
	        else
		      $error("Test case 10.2: DUT did not correctly clear the data ready flag");
	     end


	   
	   //3rd packet: framing error
	   tb_test_data = 8'b11000101;
	   
	   test_cases_stop_bit[tb_test_case] = 1'b0;
	   tb_serial_in = 1'b1;  // make sure 2 idle line
	   
	   @(posedge tb_clk);
	   @(posedge tb_clk);  //2 clock cycle idle line
	   
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   
	   //wait for processing to finish
	   fork
	      begin: processing_10_3
		 #(test_cases_bit_period[tb_test_case]);
		 disable data_ready_10_3;
	      end
	      begin: data_ready_10_3
		 @(posedge tb_data_ready);
		 disable processing_10_3;
	      end
	   join

	   //get away from clocking edge
	   #(CLK_PERIOD * 0.7);
	   
	   // Check outputs
	   assert(8'b10100011 == tb_rx_data) // it should be the previous one	
	        $info("Test case 10.3: Test data correctly thrown away");
	   else
	        $error("Test case 10.3: Test data was incorrectly received");
           assert(1'b1 == tb_framing_error)
	      $info("Test case 10.3: DUT correctly shows a framing error");
           else
	        $error("Test case 10.3: DUT incorrectly shows no framing error");
           assert(1'b0 == tb_data_ready)
	        $info("Test case 10.3: DUT correctly asserted the data ready flag");
           else
	        $error("Test case 10.3: DUT did not correctly assert the data ready flag");
           assert(1'b0 == tb_overrun_error)
	        $info("Test case 10.3: DUT correctly shows no overrun error");
           else
	        $error("Test case 10.3: DUT incorrectly shows an overrun error");
	   
	   if (test_cases_data_ready[tb_test_case] == tb_data_ready) // should not enter for this packet
	     begin
	        tb_data_read = 1'b0;
		#(CLK_PERIOD);
		tb_data_read = 1'b1;

		// Check to see if the data ready flag cleared
	        @(negedge tb_clk);
	        assert(1'b0 == tb_data_ready)
		      $info("Test case 10.3: DUT correctly cleared the data ready flag");
	        else
		      $error("Test case 10.3: DUT did not correctly clear the data ready flag");
	     end
   
	  

	   
	   // 4th packet: good packet
	   #(CLK_PERIOD);
	   tb_data_read = 1'b0;
	   
	   test_cases_stop_bit[tb_test_case] = 1'b1;
	   tb_serial_in = 1'b1;
	   
	   @(posedge tb_clk);
	   @(posedge tb_clk);  //2 clock cycle idle line
	   
	   send_packet(tb_test_data, test_cases_stop_bit[tb_test_case], test_cases_bit_period[tb_test_case]);
	   
	   //wait for processing to finish
	   fork
	      begin: processing_10_4
		 #(test_cases_bit_period[tb_test_case]);
		 disable data_ready_10_4;
	      end
	      begin: data_ready_10_4
		 @(posedge tb_data_ready);
		 disable processing_10_4;
	      end
	   join

	   //get away from clocking edge
	   #(CLK_PERIOD * 0.7);
	   
	   // Check outputs
	   assert(tb_test_data == tb_rx_data) // it should be the previous one	
	        $info("Test case 10.4: Test data correctly thrown away");
	   else
	        $error("Test case 10.4: Test data was incorrectly received");
           assert(1'b0 == tb_framing_error)
	      $info("Test case 10.4: DUT correctly shows a framing error");
           else
	        $error("Test case 10.4: DUT incorrectly shows no framing error");
           assert(1'b1 == tb_data_ready)
	        $info("Test case 10.4: DUT correctly asserted the data ready flag");
           else
	        $error("Test case 10.4: DUT did not correctly assert the data ready flag");
           assert(1'b0 == tb_overrun_error)
	        $info("Test case 10.4: DUT correctly shows no overrun error");
           else
	        $error("Test case 10.4: DUT incorrectly shows an overrun error");
	   
	   if (test_cases_data_ready[tb_test_case] == tb_data_ready) 
	     begin
	        tb_data_read = 1'b0;
		#(CLK_PERIOD);
		tb_data_read = 1'b1;

		// Check to see if the data ready flag cleared
	        @(negedge tb_clk);
	        assert(1'b0 == tb_data_ready)
		      $info("Test case 10.4: DUT correctly cleared the data ready flag");
	        else
		      $error("Test case 10.4: DUT did not correctly clear the data ready flag");
	     end
	   
	   
	end // block: TEST_PROC

   

endmodule
