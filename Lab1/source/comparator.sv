// Verilog for ECE337 Lab 1
// The Following code is used to compare 2 16-bit quantites, a and b. The code 
// determines whether or not:
// a is greater than b, gt = 1, lt = 0, eq = 0
// a is less than b, gt = 0, lt = 1, eq = 0
// a is equal to b, gt = 0, lt = 0, eq = 1

// Use a tab size of 2 spaces for best viewing results


module comparator
(
	input wire [15:0] a,
	input wire [15:0] b,
	output reg GT,
	output reg LT,
	output reg EQ
);

	reg gte;
	reg lte;

	always @ (a, b, gte, lte) begin
		if (a > b) begin
			lte = 1'b0;
			gte = 1'b1;
		end else if (b > a) begin
			gte = 1'b0;
			lte = 1'b1;
		end else begin
		  gte = 1'b0;
		  lte = 1'b0;
		 end
		
		if (lte == 1'b1) begin
			GT = 1'b0;
			LT = 1'b1;
      EQ = 1'b0;
		end else if (gte == 1'b1) begin
			GT = 1'b1;
			LT = 1'b0;
			EQ = 1'b0;
    end	else begin
			GT = 1'b0;
			LT = 1'b0;
			EQ = 1'b1;
		end
	end
endmodule