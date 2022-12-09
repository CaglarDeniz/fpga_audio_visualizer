	
module FastFourierTransform( input logic Clk, Reset,
									  input logic [23:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,
									  output logic [23:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,
									  input logic Ready, 
									  output logic frame_completed

									  
);

logic [23:0] w0,w1,w2,w3,w4,w5,w6,w7;
logic [23:0] q0,q1,q2,q3,q4,q5,q6,q7;

	// ASSIGN THE TWIDDLE FACTORs
	assign w0 = 24'h7fffff ;// N= 8, kn = 0
	assign w1 =24'h7641b3 ;
	assign w2 =24'h5a827a ; 
	assign w3 =24'h30fbc2 ;
	assign w4 =24'h000000;
	assign w5 =24'hcf043e ;
	assign w6 =24'ha57d86 ;
	assign w7 =24'h89be4d ;
	
	assign q0 =24'h000000 ;
	assign q1 =24'hcf043e ;
	assign q2 =24'ha57d86 ; 
	assign q3 =24'h89be4d ;
	assign q4 =24'h800000 ;
	assign q5 =24'h89be4d ;
	assign q6 =24'ha57d86 ;
	assign q7 =24'hcf043e ;
	
	enum logic [2:0] {wait_state,halt, stage0,stage1, stage2, stage3, stage4, frame_done } curr_state, next_state;
	// The real and imaginary components being entered in to the i
	logic [23:0]  butterfly_ir0, butterfly_ir1 ,butterfly_ir2, butterfly_ir3, butterfly_ir4, butterfly_ir5, butterfly_ir6, butterfly_ir7,
	butterfly_ir8, butterfly_ir9 ,butterfly_ir10, butterfly_ir11, butterfly_ir12, butterfly_ir13, butterfly_ir14, butterfly_ir15;
	
	logic [23:0]  butterfly_ii0, butterfly_ii1 ,butterfly_ii2, butterfly_ii3, butterfly_ii4, butterfly_ii5, butterfly_ii6, butterfly_ii7,
	butterfly_ii8, butterfly_ii9 ,butterfly_ii10, butterfly_ii11, butterfly_ii12, butterfly_ii13, butterfly_ii14, butterfly_ii15;
	
	logic [23:0]  outsignal_r0,outsignal_r1,outsignal_r2,outsignal_r3,outsignal_r4,outsignal_r5,outsignal_r6,outsignal_r7,
	outsignal_r8,outsignal_r9,outsignal_r10,outsignal_r11,outsignal_r12,outsignal_r13,outsignal_r14,outsignal_r15;
	
	logic [23:0]  outsignal_i0 ,outsignal_i1,outsignal_i2,outsignal_i3,outsignal_i4,outsignal_i5,outsignal_i6,outsignal_i7,
	outsignal_i8,outsignal_i9,outsignal_i10,outsignal_i11,outsignal_i12,outsignal_i13,outsignal_i14,outsignal_i15;
	
	logic [23:0]  twiddle_r0,twiddle_r1,twiddle_r2,twiddle_r3,twiddle_r4,twiddle_r5,twiddle_r6,twiddle_r7;
	logic [23:0]  twiddle_i0 ,twiddle_i1 ,twiddle_i2 ,twiddle_i3 , twiddle_i4,twiddle_i5, twiddle_i6,twiddle_i7;
	
	
	always_ff @ (posedge Clk or posedge Reset )
		begin
		if (Reset) // Asynchronous Reset
			curr_state <= halt; // A is the reset/start state
		else
			curr_state <= next_state;
		end
	
	
	
	always_ff@(posedge Clk)
		begin
			if (curr_state == halt)
				begin
					butterfly_ir0 <= 24'b00;
					butterfly_ir1 <= 24'b00;
					butterfly_ir2 <= 24'b00;
					butterfly_ir3 <= 24'b00;
					butterfly_ir4 <= 24'b00;
					butterfly_ir5 <= 24'b00;
					butterfly_ir6 <= 24'b00;
					butterfly_ir7 <= 24'b00;
					butterfly_ir8 <= 24'b00;
					butterfly_ir9 <= 24'b00;
					butterfly_ir10 <= 24'b00;
					butterfly_ir11 <= 24'b00;
					butterfly_ir12 <= 24'b00;
					butterfly_ir13 <= 24'b00;
					butterfly_ir14 <= 24'b00;
					butterfly_ir15 <= 24'b00;
					
					butterfly_ii0 <= 24'b00;
					butterfly_ii1 <= 24'b00;
					butterfly_ii2 <=  24'b00;
					butterfly_ii3 <= 24'b00;
					butterfly_ii4 <= 24'b00;
					butterfly_ii5 <= 24'b00;
					butterfly_ii6 <= 24'b00;
					butterfly_ii7 <= 24'b00;
					butterfly_ii8 <= 24'b00;
					butterfly_ii9 <= 24'b00;
					butterfly_ii10 <= 24'b00;
					butterfly_ii11 <= 24'b00;
					butterfly_ii12 <= 24'b00;
					butterfly_ii13 <= 24'b00;
					butterfly_ii14 <= 24'b00;
					butterfly_ii15 <= 24'b00;
					
					twiddle_r0<=  24'b00;
					twiddle_r1<=  24'b00;
					twiddle_r2<=  24'b00;
					twiddle_r3<=  24'b00;
					twiddle_r4<=  24'b00;
					twiddle_r5<=  24'b00;
					twiddle_r6<=  24'b00;
					twiddle_r7<= 24'b00;
					twiddle_i0<=  24'b00;
					twiddle_i1<=  24'b00;
					twiddle_i2<=  24'b00;
					twiddle_i3<=  24'b00;
					twiddle_i4<=  24'b00;
					twiddle_i5<=  24'b00;
					twiddle_i6<=  24'b00;
					twiddle_i7<= 24'b00;
					next_state <= wait_state;
					frame_completed <= 1'b1;				
				end
				
			else if (curr_state == wait_state)
			begin
			if (Ready)
				begin
				next_state <= stage0;
				frame_completed <= 1'b0;
				end
			else
				begin
				next_state <= wait_state;
				frame_completed <= 1'b1;
				end
			end
			else 
				begin
					if (curr_state == stage0)
						begin
							frame_completed <= 1'b0 ;
							butterfly_ir0 <= s0;
							butterfly_ir1 <= s8;
							butterfly_ir2 <= s2;
							butterfly_ir3 <= s10;
							butterfly_ir4 <= s4;
							butterfly_ir5 <= s12;
							butterfly_ir6 <= s6;
							butterfly_ir7 <= s14;
							butterfly_ir8 <= s1;
							butterfly_ir9 <= s9;
							butterfly_ir10 <= s3;
							butterfly_ir11 <= s11;
							butterfly_ir12 <= s5;
							butterfly_ir13 <= s13;
							butterfly_ir14 <= s7;
							butterfly_ir15 <= s15;
							
							butterfly_ii0 <= 24'b00;
							butterfly_ii1 <= 24'b00;
							butterfly_ii2 <= 24'b00;
							butterfly_ii3 <= 24'b00;
							butterfly_ii4 <= 24'b00;
							butterfly_ii5 <= 24'b00;
							butterfly_ii6 <= 24'b00;
							butterfly_ii7 <= 24'b00;
							butterfly_ii8 <= 24'b00;
							butterfly_ii9 <= 24'b00;
							butterfly_ii10 <= 24'b00;
							butterfly_ii11 <= 24'b00;
							butterfly_ii12 <= 24'b00;
							butterfly_ii13 <= 24'b00;
							butterfly_ii14 <= 24'b00;
							butterfly_ii15 <= 24'b00;
							
							twiddle_r0<= w0;
							twiddle_r1<= w0;
							twiddle_r2<= w0;
							twiddle_r3<= w0;
							twiddle_r4<= w0;
							twiddle_r5<= w0;
							twiddle_r6<= w0;
							twiddle_r7<= w0;
							twiddle_i0<= q0; 
							twiddle_i1<= q0;
							twiddle_i2<= q0;
							twiddle_i3<= q0;
							twiddle_i4<= q0; 
							twiddle_i5<= q0;
							twiddle_i6<= q0;
							twiddle_i7<=	q0;
							next_state <= stage1;


						end 
					else if (curr_state == stage1)
						begin
							butterfly_ir0 <= outsignal_r0;
							butterfly_ir1 <= outsignal_r2;
							butterfly_ir2 <= outsignal_r1;
							butterfly_ir3 <= outsignal_r3;
							butterfly_ir4 <= outsignal_r4;
							butterfly_ir5 <= outsignal_r6;
							butterfly_ir6 <= outsignal_r5;
							butterfly_ir7 <= outsignal_r7;
							butterfly_ir8 <= outsignal_r8;
							butterfly_ir9 <= outsignal_r10;
							butterfly_ir10 <=outsignal_r9;
							butterfly_ir11 <=outsignal_r11;
							butterfly_ir12 <=outsignal_r12;
							butterfly_ir13 <= outsignal_r14;
							butterfly_ir14 <= outsignal_r13;
							butterfly_ir15 <= outsignal_r15;
							
							butterfly_ii0 <= outsignal_i0;
							butterfly_ii1 <= outsignal_i2;
							butterfly_ii2 <= outsignal_i1; 
							butterfly_ii3 <= outsignal_i3;
							butterfly_ii4 <= outsignal_i4;
							butterfly_ii5 <= outsignal_i6;
							butterfly_ii6 <= outsignal_i5;
							butterfly_ii7 <= outsignal_i7;
							butterfly_ii8 <= outsignal_i8;
							butterfly_ii9 <= outsignal_i10;
							butterfly_ii10 <= outsignal_i9;
							butterfly_ii11 <= outsignal_i11;
							butterfly_ii12 <= outsignal_i12;
							butterfly_ii13 <= outsignal_i14;
							butterfly_ii14 <= outsignal_i13;
							butterfly_ii15 <= outsignal_i15;
							

							twiddle_r0<= w0;
							twiddle_r1<= w4;
							twiddle_r2<= w0;
							twiddle_r3<= w4;
							twiddle_r4<= w0;
							twiddle_r5<= w4;
							twiddle_r6<= w0;
							twiddle_r7<= w4;
							twiddle_i0<= q0;
							twiddle_i1<= q4;
							twiddle_i2<= q0;
							twiddle_i3<= q4;
							twiddle_i4<= q0;
							twiddle_i5<= q4;
							twiddle_i6<= q0;
							twiddle_i7<= q4;	
							next_state <= stage2;
							frame_completed <= 1'b0;
			
						end
							else if(curr_state == stage2)
						begin
							butterfly_ir0 <= outsignal_r0;
							butterfly_ir1 <= outsignal_r4;
							butterfly_ir2 <= outsignal_r2;
							butterfly_ir3 <= outsignal_r6;
							butterfly_ir4 <= outsignal_r1;
							butterfly_ir5 <= outsignal_r5;
							butterfly_ir6 <= outsignal_r3;
							butterfly_ir7 <= outsignal_r7;
							butterfly_ir8 <= outsignal_r8;
							butterfly_ir9 <= outsignal_r12;
							butterfly_ir10 <=outsignal_r9;
							butterfly_ir11 <=outsignal_r13;
							butterfly_ir12 <=outsignal_r10;
							butterfly_ir13 <= outsignal_r14;
							butterfly_ir14 <= outsignal_r11;
							butterfly_ir15 <= outsignal_r15;
							
							butterfly_ii0 <= outsignal_i0;
							butterfly_ii1 <= outsignal_i4;
							butterfly_ii2 <= outsignal_i2; 
							butterfly_ii3 <= outsignal_i6;
							butterfly_ii4 <= outsignal_i1;
							butterfly_ii5 <= outsignal_i5;
							butterfly_ii6 <= outsignal_i3;
							butterfly_ii7 <= outsignal_i7;
							butterfly_ii8 <= outsignal_i8;
							butterfly_ii9 <= outsignal_i12;
							butterfly_ii10 <= outsignal_i9;
							butterfly_ii11 <= outsignal_i13;
							butterfly_ii12 <= outsignal_i10;
							butterfly_ii13 <= outsignal_i14;
							butterfly_ii14 <= outsignal_i11;
							butterfly_ii15 <= outsignal_i15;
							
							twiddle_r0<= w0;
							twiddle_r1<= w2;
							twiddle_r2<= w4;
							twiddle_r3<= w6;
							twiddle_r4<= w0;
							twiddle_r5<= w2;
							twiddle_r6<= w4;
							twiddle_r7<= w6;
							twiddle_i0<= q0;
							twiddle_i1<= q2;
							twiddle_i2<= q4;
							twiddle_i3<= q6;
							twiddle_i4<= q0;
							twiddle_i5<= q2;
							twiddle_i6<= q4;
							twiddle_i7<= q6;
							
							next_state <= stage3;
							frame_completed <= 1'b0;

					
						end
					else if (curr_state == stage3)
						begin
							butterfly_ir0 <= outsignal_r0;
							butterfly_ir1 <= outsignal_r8;
							butterfly_ir2 <= outsignal_r2;
							butterfly_ir3 <= outsignal_r10;
							butterfly_ir4 <= outsignal_r4;
							butterfly_ir5 <= outsignal_r12;
							butterfly_ir6 <= outsignal_r6;
							butterfly_ir7 <= outsignal_r14;
							butterfly_ir8 <= outsignal_r1;
							butterfly_ir9 <= outsignal_r9;
							butterfly_ir10 <=outsignal_r3;
							butterfly_ir11 <=outsignal_r11;
							butterfly_ir12 <=outsignal_r5;
							butterfly_ir13 <= outsignal_r13;
							butterfly_ir14 <= outsignal_r7;
							butterfly_ir15 <= outsignal_r15;
							
							butterfly_ii0 <= outsignal_i0;
							butterfly_ii1 <= outsignal_i8;
							butterfly_ii2 <= outsignal_i2; 
							butterfly_ii3 <= outsignal_i10;
							butterfly_ii4 <= outsignal_i4;
							butterfly_ii5 <= outsignal_i12;
							butterfly_ii6 <= outsignal_i6;
							butterfly_ii7 <= outsignal_i14;
							butterfly_ii8 <= outsignal_i1;
							butterfly_ii9 <= outsignal_i9;
							butterfly_ii10 <= outsignal_i3;
							butterfly_ii11 <= outsignal_i11;
							butterfly_ii12 <= outsignal_i5;
							butterfly_ii13 <= outsignal_i13;
							butterfly_ii14 <= outsignal_i7;
							butterfly_ii15 <= outsignal_i15;
							
							twiddle_r0<= w0;
							twiddle_r1<= w1;
							twiddle_r2<= w2;
							twiddle_r3<= w3;
							twiddle_r4<= w4;
							twiddle_r5<= w5;
							twiddle_r6<= w6;
							twiddle_r7<= w7;
							twiddle_i0<= q0;
							twiddle_i1<= q1;
							twiddle_i2<= q2;
							twiddle_i3<= q3;
							twiddle_i4<= q4;
							twiddle_i5<= q5;
							twiddle_i6<= q6;
							twiddle_i7<=	q7;
							next_state <= stage4;
							frame_completed <= 1'b0;
				
												
						end
					else if(curr_state == stage4)
						begin
							butterfly_ir0 <= outsignal_r0;
							butterfly_ir1 <= outsignal_r2;
							butterfly_ir2 <= outsignal_r4;
							butterfly_ir3 <= outsignal_r6;
							butterfly_ir4 <= outsignal_r8;
							butterfly_ir5 <= outsignal_r10;
							butterfly_ir6 <= outsignal_r12;
							butterfly_ir7 <= outsignal_r14;
							butterfly_ir8 <= outsignal_r1;
							butterfly_ir9 <= outsignal_r3;
							butterfly_ir10 <=outsignal_r5;
							butterfly_ir11 <=outsignal_r7;
							butterfly_ir12 <=outsignal_r9;
							butterfly_ir13 <= outsignal_r11;
							butterfly_ir14 <= outsignal_r13;
							butterfly_ir15 <= outsignal_r15;
							
							butterfly_ii0 <= outsignal_i0;
							butterfly_ii1 <= outsignal_i2;
							butterfly_ii2 <= outsignal_i4; 
							butterfly_ii3 <= outsignal_i6;
							butterfly_ii4 <= outsignal_i8;
							butterfly_ii5 <= outsignal_i10;
							butterfly_ii6 <= outsignal_i12;
							butterfly_ii7 <= outsignal_i14;
							butterfly_ii8 <= outsignal_i1;
							butterfly_ii9 <= outsignal_i3;
							butterfly_ii10 <= outsignal_i5;
							butterfly_ii11 <= outsignal_i7;
							butterfly_ii12 <= outsignal_i9;
							butterfly_ii13 <= outsignal_i11;
							butterfly_ii14 <= outsignal_i13;
							butterfly_ii15 <= outsignal_i15;
							
							twiddle_r0<= w0;
							twiddle_r1<= w0;
							twiddle_r2<= w0;
							twiddle_r3<= w0;
							twiddle_r4<= w0;
							twiddle_r5<= w0;
							twiddle_r6<= w0;
							twiddle_r7<= w0;
							twiddle_i0<= q0; 
							twiddle_i1<= q0;
							twiddle_i2<= q0;
							twiddle_i3<= q0;
							twiddle_i4<= q0; 
							twiddle_i5<= q0;
							twiddle_i6<= q0;
							twiddle_i7<=	q0;
							next_state <= frame_done;
							frame_completed <= 1'b0;

						end
						else if (curr_state == frame_done)
							begin
							// Convert negative twos complement to positive value//
							if (outsignal_r0[23] == 1)
								 outsignal_r0 <= (outsignal_r0 ^ 24'hffffff)+24'd1;
							if (outsignal_r1[23] == 1)
								 outsignal_r1 <= (outsignal_r1 ^ 24'hffffff)+24'd1;
							if (outsignal_r2[23] == 1)
								 outsignal_r2 <= (outsignal_r2 ^ 24'hffffff)+24'd1;
							if (outsignal_r3[23] == 1)
								 outsignal_r3 <= (outsignal_r3 ^ 24'hffffff)+24'd1;
							if (outsignal_r4[23] == 1)
								 outsignal_r4 <= (outsignal_r4 ^ 24'hffffff)+24'd1;
							if (outsignal_r5[23] == 1)
								 outsignal_r5 <= (outsignal_r5 ^ 24'hffffff)+24'd1;
							if (outsignal_r6[23] == 1)
								 outsignal_r6 <= (outsignal_r6 ^ 24'hffffff)+24'd1;
							if (outsignal_r7[23] == 1)
								 outsignal_r7 <= (outsignal_r7 ^ 24'hffffff)+24'd1;
							if (outsignal_r8[23] == 1)
								 outsignal_r8 <= (outsignal_r8 ^ 24'hffffff)+24'd1;
							if (outsignal_r9[23] == 1)
								 outsignal_r9 <= (outsignal_r9 ^ 24'hffffff)+24'd1;
							if (outsignal_r10[23] == 1)
								 outsignal_r10 <= (outsignal_r10 ^ 24'hffffff)+24'd1;
							if (outsignal_r11[23] == 1)
								 outsignal_r11 <= (outsignal_r11 ^ 24'hffffff)+24'd1;
							if (outsignal_r12[23] == 1)
								 outsignal_r12 <= (outsignal_r12 ^ 24'hffffff)+24'd1;
							if (outsignal_r13[23] == 1)
								 outsignal_r13 <= (outsignal_r13 ^ 24'hffffff)+24'd1;
							if (outsignal_r14[23] == 1)
								 outsignal_r14 <= (outsignal_r14 ^ 24'hffffff)+24'd1;
							if (outsignal_r15[23] == 1)
								 outsignal_r15 <= (outsignal_r15 ^ 24'hffffff)+24'd1;
	
							x0 <= outsignal_r0;
							x1 <= outsignal_r1;
							x2 <= outsignal_r2;
							x3 <= outsignal_r3;
							x4 <= outsignal_r4;
							x5 <= outsignal_r5;
							x6 <= outsignal_r6;
							x7 <= outsignal_r7;
							x8 <= outsignal_r8;
							x9 <= outsignal_r9;
							x10 <= outsignal_r10;
							x11 <= outsignal_r11;
							x12 <= outsignal_r12;
							x13 <= outsignal_r13;
							x14 <= outsignal_r14;
							x15 <= outsignal_r15;
							next_state <= halt;
							end
				end	
		end
		
butterfly butterfly_c1( .a_real(butterfly_ir0), .a_imag(butterfly_ii0), .b_real(butterfly_ir1), .b_imag(butterfly_ii1), .twiddle_real(twiddle_r0), .twiddle_imag(twiddle_i0), 
						 .A_real(outsignal_r0), .A_imag(outsignal_i0) , .B_real(outsignal_r1), .B_imag(outsignal_i1));
						
butterfly butterfly_c2( .a_real(butterfly_ir2), .a_imag(butterfly_ii2), .b_real(butterfly_ir3), .b_imag(butterfly_ii3), .twiddle_real(twiddle_r1), .twiddle_imag(twiddle_i1), 
						 .A_real(outsignal_r2), .A_imag(outsignal_i2) , .B_real(outsignal_r3), .B_imag(outsignal_i3));
						 
butterfly butterfly_c3( .a_real(butterfly_ir4), .a_imag(butterfly_ii4), .b_real(butterfly_ir5), .b_imag(butterfly_ii5), .twiddle_real(twiddle_r2), .twiddle_imag(twiddle_i2), 
						 .A_real(outsignal_r4), .A_imag(outsignal_i4) , .B_real(outsignal_r5), .B_imag(outsignal_i5));

butterfly butterfly_c4( .a_real(butterfly_ir6), .a_imag(butterfly_ii6), .b_real(butterfly_ir7), .b_imag(butterfly_ii7), .twiddle_real(twiddle_r3), .twiddle_imag(twiddle_i3), 
						 .A_real(outsignal_r6), .A_imag(outsignal_i6) , .B_real(outsignal_r7), .B_imag(outsignal_i7));

butterfly butterfly_c5( .a_real(butterfly_ir8), .a_imag(butterfly_ii8), .b_real(butterfly_ir9), .b_imag(butterfly_ii9), .twiddle_real(twiddle_r4), .twiddle_imag(twiddle_i4), 
						 .A_real(outsignal_r8), .A_imag(outsignal_i8) , .B_real(outsignal_r9), .B_imag(outsignal_i9));

butterfly butterfly_c6( .a_real(butterfly_ir10), .a_imag(butterfly_ii10), .b_real(butterfly_ir11), .b_imag(butterfly_ii11), .twiddle_real(twiddle_r5), .twiddle_imag(twiddle_i5), 
						 .A_real(outsignal_r10), .A_imag(outsignal_i10) , .B_real(outsignal_r11), .B_imag(outsignal_i11));

butterfly butterfly_c7( .a_real(butterfly_ir12), .a_imag(butterfly_ii12), .b_real(butterfly_ir13), .b_imag(butterfly_ii13), .twiddle_real(twiddle_r6), .twiddle_imag(twiddle_i6), 
						 .A_real(outsignal_r12), .A_imag(outsignal_i12) , .B_real(outsignal_r13), .B_imag(outsignal_i13));

butterfly butterfly_c8( .a_real(butterfly_ir14), .a_imag(butterfly_ii14), .b_real(butterfly_ir15), .b_imag(butterfly_ii15), .twiddle_real(twiddle_r7), .twiddle_imag(twiddle_i7), 
						 .A_real(outsignal_r14), .A_imag(outsignal_i14) , .B_real(outsignal_r15), .B_imag(outsignal_i15));						 

endmodule 