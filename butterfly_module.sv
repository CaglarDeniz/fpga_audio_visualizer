module butterfly( input logic [23:0] a_real, input logic [23:0] a_imag, input logic [23:0] b_real, input logic [23:0] b_imag, input logic [23:0] twiddle_real, input logic [23:0] twiddle_imag, 
						output logic [23:0] A_real, output logic [23:0] A_imag, output logic [23:0] B_real, output logic [23:0] B_imag);
								 
	
	
	
	logic [47:0] real_comp;
	logic [47:0] imag_comp;
	logic [47:0] real_imag_comp;
	logic [47:0] imag_real_comp;
	logic [47:0] real_a;
	logic [47:0] imag_a;
	logic [23:0] b_W_real;
	logic [23:0] b_W_imag;
	always_comb
		begin
		// Multiplying Odd Index Samples with Twiddle
		
		real_comp = b_real * twiddle_real;
		imag_comp = b_imag * twiddle_imag;
		real_imag_comp = b_real * twiddle_imag;
		imag_real_comp = b_imag * twiddle_real;
		
		// Truncate multiplied values
		
		real_a = real_comp + imag_comp;
		imag_a = real_imag_comp + imag_real_comp;
		b_W_real = {real_a[47],real_a[22:0]};
		b_W_imag = {imag_a[47],imag_a[22:0]};
		
		// Compute Output
		A_real = a_real + b_W_real;
		A_imag = a_imag + b_W_imag;
		
		B_real = a_real - b_W_real;
		B_imag = a_imag - b_W_imag;
		end
						 
endmodule

