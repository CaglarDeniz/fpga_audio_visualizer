module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the logic_processor_8bit will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic [9:0] SW;

logic vs,hs;
logic [3:0] r,g,b;
		
// Make sure the module and signal names match with those in your design
bar_graph bar(
	 // System clock
	.MAX10_CLK1_50(Clk),
	
	// Button
	.Reset(1'b1),
	
	// Switch input
	.SW(SW),
	
	// VGA
	.VGA_VS(vs),.VGA_HS(hs),
	.VGA_R(r),.VGA_G(g),.VGA_B(b)
);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS

SW = 10'b0101010101;

#1500

#1500

#1500

#1500


$display("Simulation succesfully completed");
end

endmodule
