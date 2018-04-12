module LUTable (codeword, mapped_0, mapped_1, mapped_2, mapped_3, mapped_4, mapped_5, mapped_6, mapped_7);	
input [7:0] codeword;
output reg[7:0] mapped_0;
output reg[7:0] mapped_1;
output reg[7:0] mapped_2;
output reg[7:0] mapped_3;
output reg[7:0] mapped_4;
output reg[7:0] mapped_5;
output reg[7:0] mapped_6;
output reg[7:0] mapped_7;
parameter C = 7'b0010000;

always @* begin 
mapped_0 <= {~codeword[7], C};
mapped_1 <= {~codeword[6], C};
mapped_2 <= {~codeword[5], C};
mapped_3 <= {~codeword[4], C};
mapped_4 <= {~codeword[3], C};
mapped_5 <= {~codeword[2], C};
mapped_6 <= {~codeword[1], C};
mapped_7 <= {~codeword[0], C};

end
endmodule
