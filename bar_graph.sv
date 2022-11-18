module bar_graph(
	
	// System clock
	input MAX10_CLK1_50,
	
	// Button
	input Reset,
	
	// Switch input
	input [9:0] SW,
	
	// VGA
	output VGA_VS,VGA_HS,
	output [3:0] VGA_R,VGA_G,VGA_B
);

// background and foreground colors
logic [3:0] BGR_B = 4'd8;
logic [3:0] FGR_R = 4'd8;

// internal BAR variables, setting bar amplitudes to be constant
logic [9:0] BAR_X[10] ;
logic [9:0] BAR_Y[10] ;
logic [9:0] BAR_EN;

// VGA Locals
logic VGA_CLK,blank,sync;

logic [9:0] DrawX,DrawY;

logic Reset_h;

assign BAR_EN = SW;
assign Reset_h = ~Reset;

// BAR_GAP is 10px
// BAR_WIDTH is 53px
// One bar unit takes up 63px with gap.

always_comb
begin
	for(int i = 0 ; i < 10; i++) begin
		BAR_X[i] = 63 * i + 10;
	end
end

// update BAR positions with frame clock
always_ff @ (posedge VGA_VS)
begin
	for(int i = 0 ; i < 10; i++) begin
		if(BAR_EN[i]) 
			BAR_Y[i] <= 30 * i;
		else
			BAR_Y[i] <= 0;
	end
end

logic BAR_IN;


// determine if DrawX and DrawY are inside a bar or not
always_comb 
begin

	for(int i = 0 ; i < 10 ; i++) begin
	
		if(DrawX >= BAR_X[i] && DrawX <= BAR_X[i] + 53 && DrawY <= BAR_Y[i] &&  BAR_EN[i]) begin
			// if pixel is inside a bar color it red
			VGA_R = FGR_R;
			VGA_B = 4'h0;
			VGA_G = 4'h0;
		end
		
		else begin
			// else color it blue
			VGA_R = 4'h0;
			VGA_B = BGR_B;
			VGA_G = 4'h0;
		end	
	end
end

// module instantiations
vga_controller vga(.Clk(MAX10_CLK1_50),       // 50 MHz clock
						.Reset(Reset_h),     // reset signal
                  .hs(VGA_HS),        // Horizontal sync pulse.  Active low
						.vs(VGA_VS),        // Vertical sync pulse.  Active low
						.pixel_clk(VGA_CLK), // 25 MHz pixel clock output
						.blank(blank),     // Blanking interval indicator.  Active low.
						.sync(sync),      // Composite Sync signal.  Active low.  We don't use it in this lab,
										//   but the video DAC on the DE2 board requires an input for it.
						.DrawX(DrawX),     // horizontal coordinate
						.DrawY(DrawY) // vertical coordinate
);

endmodule
