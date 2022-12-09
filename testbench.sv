module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the logic_processor_8bit will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset = 1;
logic [23:0] s0,  s1,   s2,   s3,   s4,   s5,   s6,   s7,  s8,   s9,
 s10,   s11,   s12,   s13,   s14,   s15,   x0,   x1,   x2 ,   x3, 
 x4,   x5,   x6,   x7,   x8 ,   x9,   x10,   x11,   x12,   x13,
 x14,   x15;
 logic frame_completed;
 logic Ready = 0;
//logic [9:0] SW;
//logic Key;
//
//logic vs,hs;
//logic [7:0] r,g,b;
//
//logic [9:0] BallX,BallY,Ball_size,DrawX,DrawY;
		
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
//);'

lab62 top(///////// Clocks /////////
      .MAX10_CLK1_50(Clk), 

      ///////// KEY /////////
      .KEY({1'b0, Reset}),

      ///////// SW /////////
      .SW(9'h0));

//FastFourierTransform fft(.*);

//color_mapper color( .*,
//								 .Clk(Clk),.Button(Key),
//                       .Red(r), .Green(g), .Blue(b) );

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

# 10

s15 = 24'd0;
s14 = 24'd1;
s13 = 24'd2;
s12 = 24'd3;
s11 = 24'd0;
s10 = 24'd5;
s9 = 24'd6;
s8 = 24'd7;
s7 = 24'd8;
s6 = 24'd9;
s5 = 24'd8;
s4 = 24'd7;
s3 = 24'd6;
s2 = 24'd3;
s1 = 24'd14;
s0 = 24'd15;

#2 
Reset = 1'b0;

#2 Reset = 1'b1;

# 1000

#2 Ready = 1'b1;

//Key=0;
//DrawX = 10'd0;
//DrawY = 10'd10;
//
//#2
//
//DrawX = 10'd15;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd80;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd140;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd205;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd270;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd340;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd395;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd460;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd520;
//DrawY = 10'd480;
//
//#2
//
//DrawX = 10'd580;
//DrawY = 10'd480;
//
//#2


$display("Simulation succesfully completed");
end

endmodule
