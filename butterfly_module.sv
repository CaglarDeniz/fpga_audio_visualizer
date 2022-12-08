module butterfly( input[47:0] a_n, input[47:0] b_n, input[48:0] W_n,
								 output [47:0] A_n, output [47:0] B_n);
								 
	always_comb
		begin
			A_n = a_n + W_n * b_n;
			B_n = a_n - W_n * b_n;
		end
						 
								 
endmodule

