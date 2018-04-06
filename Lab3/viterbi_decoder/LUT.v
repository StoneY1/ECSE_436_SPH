module LUT (	uni_1, codeword,	mappedCodeword0, mappedCodeword1, mappedCodeword2,
mappedCodeword3, mappedCodeword4, mappedCodeword5, mappedCodeword6, mappedCodeword7	);	
input reg[7:0] codeword;

output reg[7:0] mappedCodeword0;
output reg[7:0] mappedCodeword1;
output reg[7:0] mappedCodeword2;
output reg[7:0] mappedCodeword3;
output reg[7:0] mappedCodeword4;
output reg[7:0] mappedCodeword5;
output reg[7:0] mappedCodeword6;
output regs[7:0] mappedCodeword7;

parameter C = 7'b001000;

always @* begin 
mappedCodeword0 <= {!codeword[0], C};
mappedCodeword1 <= {!codeword[1], C};
mappedCodeword2 <= {!codeword[2], C};
mappedCodeword3 <= {!codeword[3], C};
mappedCodeword4 <= {!codeword[4], C};
mappedCodeword5 <= {!codeword[5], C};
mappedCodeword6 <= {!codeword[6], C};
mappedCodeword7 <= {!codeword[7], C};

end
endmodule