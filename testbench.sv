module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the logic_processor_8bit will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic [9:0] SW;
logic Key;

logic vs,hs;
logic [7:0] r,g,b;

logic [9:0] BallX,BallY,Ball_size,DrawX,DrawY;
		
// Make sure the module and signal names match with those in your design
//bar_graph bar(
//	 // System clock
//	.MAX10_CLK1_50(Clk),
//	
//	// Button
//	.Reset(1'b1),
//	
//	// Switch input
//	.SW(SW),
//	
//	// VGA
//	.VGA_VS(vs),.VGA_HS(hs),
//	.VGA_R(r),.VGA_G(g),.VGA_B(b)
//);

color_mapper color( .*,
								 .Clk(Clk),.Button(Key),
                       .Red(r), .Green(g), .Blue(b) );

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

Key=0;
DrawX = 10'd0;
DrawY = 10'd10;

#2

DrawX = 10'd15;
DrawY = 10'd480;

#2

DrawX = 10'd80;
DrawY = 10'd480;

#2

DrawX = 10'd140;
DrawY = 10'd480;

#2

DrawX = 10'd205;
DrawY = 10'd480;

#2

DrawX = 10'd270;
DrawY = 10'd480;

#2

DrawX = 10'd340;
DrawY = 10'd480;

#2

DrawX = 10'd395;
DrawY = 10'd480;

#2

DrawX = 10'd460;
DrawY = 10'd480;

#2

DrawX = 10'd520;
DrawY = 10'd480;

#2

DrawX = 10'd580;
DrawY = 10'd480;

#2


$display("Simulation succesfully completed");
end

endmodule
