module bar_graph(
	
	// System clock
	input MAX10_CLK1_50,
	
	// Button
	input Reset,
	
	// Switch input
	input [9:0] SW,
	
	// VGA
	output [7:0] VGA_R,VGA_G,VGA_B
);

//// background and foreground colors
//logic [3:0] BGR_B = 4'd8;
//logic [3:0] FGR_R = 4'd8;
//
//// internal BAR variables, setting bar amplitudes to be constant
//logic [9:0] BAR_X[10] ;
//logic [9:0] BAR_Y[10] ;
//logic [9:0] BAR_EN;

// VGA Locals
logic VGA_CLK,blank,sync;
logic [3:0] red,green,blue;

logic [9:0] DrawX,DrawY;

logic Reset_h;

assign BAR_EN = SW;
assign Reset_h = ~Reset;

always_comb begin

	VGA_R = 8'h00;
	VGA_G = 8'h00;
	VGA_B = 8'h00;

end
//
//// BAR_GAP is 10px
//// BAR_WIDTH is 53px
//// One bar unit takes up 63px with gap.
//
//always_comb
//begin
//	for(int i = 0 ; i < 10; i++) begin
//		BAR_X[i] = 63 * i + 10;
//	end
//end
//
//// update BAR positions with frame clock
//always_ff @ (posedge VGA_VS)
//begin
//	for(int i = 0 ; i < 10; i++) begin
//		if(BAR_EN[i]) 
//			BAR_Y[i] <= 30 * i;
//		else
//			BAR_Y[i] <= 0;
//	end
//end

// determine if DrawX and DrawY are inside a bar or not
//always_comb 
//begin
//
//	for(int i = 0 ; i < 10 ; i++) begin
//	
//		if(DrawX >= BAR_X[i] && DrawX <= BAR_X[i] + 53 && DrawY <= BAR_Y[i] &&  BAR_EN[i]) begin
//			// if pixel is inside a bar color it red
//			red = FGR_R;
//			green = 4'hF;
//			blue = 4'hF;
//		end
//		
//		else begin
//			// else color it blue
//			red = 4'hF;
//			green = BGR_B;
//			blue = 4'hF;
//		end	
//	end
//end

endmodule
