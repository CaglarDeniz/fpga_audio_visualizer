//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
								input Clk,Button,
								input logic [23:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
	  
//// background and foreground colors
//logic [3:0] BGR_B = 4'd8;
//logic [3:0] FGR_R = 4'd8;

// internal BAR variables, setting bar amplitudes to be constant
logic [9:0] BAR_X[10] ;
logic [8:0] BAR_Y[10] ;
logic [9:0] BAR_EN;

// BAR_GAP is 10px
// BAR_WIDTH is 53px
// One bar unit takes up 63px with gap.

always_comb
begin
	
	BAR_X[0] = 10'd10;
	BAR_X[1] = 10'd73;
	BAR_X[2] = 10'd136;
	BAR_X[3] = 10'd199;
	BAR_X[4] = 10'd262;
	BAR_X[5] = 10'd325;
	BAR_X[6] = 10'd388;
	BAR_X[7] = 10'd451;
	BAR_X[8] = 10'd514;
	BAR_X[9] = 10'd577;
end

// update BAR positions with frame clock
always_comb
begin
	BAR_Y[0] = 9'd480 - x0[22:14];
	BAR_Y[1] = 9'd480 - x1[22:14];	
	BAR_Y[2] = 9'd480 - x2[22:14];
	BAR_Y[3] = 9'd480 - x3[22:14];
	BAR_Y[4] = 9'd480 - x4[22:14];
	BAR_Y[5] = 9'd480 - x5[22:14];
	BAR_Y[6] = 9'd480 - x6[22:14];
	BAR_Y[7] = 9'd480 - x7[22:14];
	BAR_Y[8] = 9'd480 - x8[22:14];
	BAR_Y[9] = 9'd480 - x9[22:14];
//	if(Button)
//		BAR_Y[0] = 10'd480 - 10'd50;
//	else
//		BAR_Y[0] = 10'd480 - 10'd100;
//	if(Button)
//		BAR_Y[1] = 10'd480 - 10'd30;
//	else
//		BAR_Y[1] = 10'd480 - 10'd60;
//	if(Button)
//		BAR_Y[2] = 10'd480 - 10'd120;
//	else
//		BAR_Y[2] = 10'd480 - 10'd60;
//	if(Button)
//		BAR_Y[3] = 10'd480 - 10'd90;
//	else
//		BAR_Y[3] = 10'd480 - 10'd180;
//	if(Button)
//		BAR_Y[4] = 10'd480 - 10'd240;
//	else
//		BAR_Y[4] = 10'd480 - 10'd120;
//	if(Button)
//		BAR_Y[5] = 10'd480 - 10'd150;
//	else
//		BAR_Y[5] = 10'd480 - 10'd300;
//	if(Button)
//		BAR_Y[6] = 10'd480 - 10'd360;
//	else
//		BAR_Y[6] = 10'd480 - 10'd180;
//	if(Button)
//		BAR_Y[7] = 10'd480 - 10'd210;
//	else
//		BAR_Y[7] = 10'd480 - 10'd420;
//	if(Button)
//		BAR_Y[8] = 10'd480 - 10'd50;
//	else
//		BAR_Y[8] = 10'd480 - 10'd100;
//	if(Button)
//		BAR_Y[9] = 10'd480 - 10'd120;
//	else
//		BAR_Y[9] = 10'd480 - 10'd60;
	
end

always_comb
begin
	if ((DrawX >= BAR_X[0] && DrawX <= BAR_X[0] + 53 && DrawY >= BAR_Y[0])) 
		BAR_EN[0] = 1'b1;
	else
		BAR_EN[0] = 1'b0;
	if ((DrawX >= BAR_X[1] && (DrawX <= BAR_X[1] + 53) && DrawY >= BAR_Y[1])) 
		BAR_EN[1] = 1'b1;
	else
		BAR_EN[1] = 1'b0;
	if ((DrawX >= BAR_X[2] && DrawX <= BAR_X[2] + 53 && DrawY >= BAR_Y[2])) 
		BAR_EN[2] = 1'b1;
	else
		BAR_EN[2] = 1'b0;
	if ((DrawX >= BAR_X[3] && DrawX <= BAR_X[3] + 53 && DrawY >= BAR_Y[3])) 
		BAR_EN[3] = 1'b1;
	else
		BAR_EN[3] = 1'b0;
	if ((DrawX >= BAR_X[4] && DrawX <= BAR_X[4] + 53 && DrawY >= BAR_Y[4])) 
		BAR_EN[4] = 1'b1;
	else
		BAR_EN[4] = 1'b0;
	if ((DrawX >= BAR_X[5] && DrawX <= BAR_X[5] + 53 && DrawY >= BAR_Y[5])) 
		BAR_EN[5] = 1'b1;
	else
		BAR_EN[5] = 1'b0;
	if ((DrawX >= BAR_X[6] && DrawX <= BAR_X[6] + 53 && DrawY >= BAR_Y[6])) 
		BAR_EN[6] = 1'b1;
	else
		BAR_EN[6] = 1'b0;
	if ((DrawX >= BAR_X[7] && DrawX <= BAR_X[7] + 53 && DrawY >= BAR_Y[7])) 
		BAR_EN[7] = 1'b1;
	else
		BAR_EN[7] = 1'b0;
	if ((DrawX >= BAR_X[8] && DrawX <= BAR_X[8] + 53 && DrawY >= BAR_Y[8])) 
		BAR_EN[8] = 1'b1;
	else
		BAR_EN[8] = 1'b0;
	if ((DrawX >= BAR_X[9] && DrawX <= BAR_X[9] + 53 && DrawY >= BAR_Y[9])) 
		BAR_EN[9] = 1'b1;
	else
		BAR_EN[9] = 1'b0;
end

// //determine if DrawX and DrawY are inside a bar or not
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

	  
//    int DistX, DistY, Size;
//	 assign DistX = DrawX - BallX;
//    assign DistY = DrawY - BallY;
//    assign Size = Ball_size;
	  
//    always_comb
//    begin:Ball_on_proc
//        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
//            ball_on = 1'b1;
//        else 
//            ball_on = 1'b0;
//     end 
       
    always_comb
    begin:RGB_Display
        if ((BAR_EN & 10'h3FF) != 10'h0) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
            Blue = 8'h00;
        end       
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 
    
endmodule
