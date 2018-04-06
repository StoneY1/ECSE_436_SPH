module quantizer (inp, bits, outp);
	input reg [31:0] inp;
	input reg [2:0] bits;
	output reg	[31:0] outp;	

always@*
begin
	//one case that is unquantized
	if (bits ==3'd6)
	begin 
	outp <= inp;
	end
	
	//1 bit sample
	else if (bits == 3'd1) //single bit quantization
	begin
		outp <= {inp[31], 31'b0}; 
	end
		//2 bit sample
	else if (bits == 3'h2) 
	begin
		outp <= {inp[31:30], 30'b0};
	end
	//3 bit sample
	else if (bits == 3'h3) 
	begin
		outp <= {inp[31:29], 29'b0};
	end
	//4 bit sample
	else if (bits == 3'h4)
	begin
		outp <= {inp[31:28], 28'b0};
	end
	//8 bit sample
	else if (bits == 3'h7) 
	begin
		outp <= {inp[31:24], 24'b0};
	end
	
end
endmodule
