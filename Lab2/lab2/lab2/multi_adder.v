//Stone Yun 260616314
//Adds together 6 inputs that are each 32 bit vectors
module multi_Add (uni_1, uni_2, uni_3, uni_4, uni_5, uni_6, sum, cout);

	input reg[31:0] uni_1;
	input reg[31:0] uni_2;
	input reg[31:0] uni_3;
	input reg[31:0] uni_4;
	input reg[31:0] uni_5;
	input reg[31:0] uni_6;
	output reg[31:0] sum;
	output cout;
	assign {cout,sum} = uni_1+uni_2+uni_3+uni_4+uni_5+uni_6;
endmodule
